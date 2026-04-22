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
        s.sendall(f'{cwd}\n{comp_line}'.encode())
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


if __name__ == '__main__':
    unittest.main()
