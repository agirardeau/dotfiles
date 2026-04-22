import os
import socket
import subprocess
import sys
import tempfile
import time
import unittest

RUN_PY = os.path.normpath(os.path.join(os.path.dirname(__file__), '..', '..', 'run.py'))

AG_TOML = """\
[root]
values = ["repo", "help"]

[subcommands.repo]
values = ["create"]
"""

_daemon_proc = None
_daemon_sock_path = None
_daemon_tmp = None


def setUpModule():
    global _daemon_proc, _daemon_sock_path, _daemon_tmp
    _daemon_tmp = tempfile.TemporaryDirectory()
    config_dir = os.path.join(_daemon_tmp.name, 'config')
    os.makedirs(config_dir)
    with open(os.path.join(config_dir, 'ag.toml'), 'w') as f:
        f.write(AG_TOML)

    env = {
        **os.environ,
        'XDG_RUNTIME_DIR': _daemon_tmp.name,
        'COMPLETION_CONFIG_DIR': config_dir,
        'LISTEN_FDS': '0',
    }
    _daemon_proc = subprocess.Popen([sys.executable, RUN_PY], env=env, stderr=subprocess.PIPE)

    _daemon_sock_path = os.path.join(_daemon_tmp.name, 'ag-completion.sock')
    for _ in range(40):
        if os.path.exists(_daemon_sock_path):
            break
        time.sleep(0.05)
    else:
        _daemon_proc.terminate()
        raise RuntimeError(f'daemon socket did not appear at {_daemon_sock_path}')


def tearDownModule():
    _daemon_proc.terminate()
    _daemon_proc.wait()
    _daemon_tmp.cleanup()


def query(cwd, comp_line):
    with socket.socket(socket.AF_UNIX, socket.SOCK_STREAM) as s:
        s.connect(_daemon_sock_path)
        s.sendall(f'COMPLETE\n{cwd}\n{comp_line}'.encode())
        s.shutdown(socket.SHUT_WR)
        chunks = []
        while True:
            chunk = s.recv(4096)
            if not chunk:
                break
            chunks.append(chunk)
        return b''.join(chunks).decode()


def reload_daemon():
    with socket.socket(socket.AF_UNIX, socket.SOCK_STREAM) as s:
        s.connect(_daemon_sock_path)
        s.sendall(b'RELOAD\n')
        s.shutdown(socket.SHUT_WR)
        chunks = []
        while True:
            chunk = s.recv(4096)
            if not chunk:
                break
            chunks.append(chunk)
        return b''.join(chunks).decode()


class TestSocket(unittest.TestCase):
    def test_root_completions(self):
        self.assertEqual(set(query('/tmp', 'ag ').split('\n')), {'repo', 'help'})

    def test_subcommand_completions(self):
        self.assertEqual(query('/tmp', 'ag repo '), 'create')

    def test_no_config_returns_file_listing(self):
        with tempfile.TemporaryDirectory() as d:
            open(os.path.join(d, 'afile'), 'w').close()
            self.assertIn('afile', query(d, 'unknowncmd ').split('\n'))

    def test_unknown_subcommand_returns_file_listing(self):
        with tempfile.TemporaryDirectory() as d:
            open(os.path.join(d, 'myfile'), 'w').close()
            self.assertIn('myfile', query(d, 'ag nope ').split('\n'))

    def test_daemon_handles_sequential_requests(self):
        self.assertEqual(set(query('/tmp', 'ag ').split('\n')), {'repo', 'help'})
        self.assertEqual(query('/tmp', 'ag repo '), 'create')
        self.assertEqual(set(query('/tmp', 'ag ').split('\n')), {'repo', 'help'})

    def test_reload_is_selective(self):
        config_dir = os.path.join(_daemon_tmp.name, 'config')
        path_stay = os.path.join(config_dir, 'stycmd.toml')
        path_change = os.path.join(config_dir, 'chgcmd.toml')
        try:
            with open(path_stay, 'w') as f:
                f.write('[root]\nvalues = ["stay_val"]\n')
            with open(path_change, 'w') as f:
                f.write('[root]\nvalues = ["old_val"]\n')

            # Populate cache for both commands
            self.assertEqual(query('/tmp', 'stycmd '), 'stay_val')
            self.assertEqual(query('/tmp', 'chgcmd '), 'old_val')

            # Overwrite chgcmd (changes mtime), leave stycmd untouched
            original_mtime_ns = os.stat(path_change).st_mtime_ns
            with open(path_change, 'w') as f:
                f.write('[root]\nvalues = ["new_val"]\n')
            # Guarantee mtime differs even if both writes land on the same clock tick
            os.utime(path_change, ns=(original_mtime_ns + 1_000_000_000, original_mtime_ns + 1_000_000_000))

            self.assertEqual(reload_daemon(), 'OK')

            # chgcmd evicted — picks up new config
            self.assertEqual(query('/tmp', 'chgcmd '), 'new_val')

            # stycmd not evicted — delete the file to prove the value is served from cache
            os.unlink(path_stay)
            self.assertEqual(query('/tmp', 'stycmd '), 'stay_val')
        finally:
            for p in (path_stay, path_change):
                try:
                    os.unlink(p)
                except FileNotFoundError:
                    pass

    def test_reload_picks_up_new_config(self):
        config_dir = os.path.join(_daemon_tmp.name, 'config')
        new_toml_path = os.path.join(config_dir, 'newcmd.toml')
        try:
            with tempfile.TemporaryDirectory() as cwd:
                # First query caches None for newcmd (no config file yet)
                query(cwd, 'newcmd ')

                # Write a config file for newcmd
                with open(new_toml_path, 'w') as f:
                    f.write('[root]\nvalues = ["alpha", "beta"]\n')

                # Cache still holds None for newcmd, so file listing is returned (empty dir → '')
                result_before = query(cwd, 'newcmd ')
                self.assertEqual(result_before, '')

                # Reload clears the cache
                self.assertEqual(reload_daemon(), 'OK')

                # Now the daemon reads the new config
                result_after = query(cwd, 'newcmd ')
                self.assertEqual(set(result_after.split('\n')), {'alpha', 'beta'})
        finally:
            try:
                os.unlink(new_toml_path)
            except FileNotFoundError:
                pass


if __name__ == '__main__':
    unittest.main()
