#!/usr/bin/env python3

# Completion service daemon
# Listens on a Unix socket (via systemd socket activation or self-bound fallback).
# Receives "{CWD}\n{COMP_LINE}" and writes newline-separated completion candidates back.
# Completions are driven by config/{COMMAND}.toml; falls back to file listing from CWD.

import os
import socket
import subprocess
import tomllib

SD_LISTEN_FDS_START = 3
CONFIG_DIR = os.environ.get('COMPLETION_CONFIG_DIR', os.path.join(os.path.dirname(__file__), 'config'))


def load_config(command):
    path = os.path.join(CONFIG_DIR, f'{command}.toml')
    try:
        with open(path, 'rb') as f:
            return tomllib.load(f)
    except FileNotFoundError:
        return None


def navigate(config, words, depth):
    """Return the config node for the current completion depth, or None for file-based."""
    if depth == 1:
        return config.get('root')
    node = config
    for word in words[1:depth]:
        subcommands = node.get('subcommands', {})
        if word in subcommands:
            node = subcommands[word]
        else:
            return None
    return node


def file_candidates(cwd, prefix):
    try:
        return [e for e in os.listdir(cwd) if e.startswith(prefix)]
    except OSError:
        return []


def completions(cwd, comp_line):
    raw = comp_line.rstrip('\n')
    ends_with_space = raw.endswith(' ')
    words = [w for w in raw.strip().split() if w]

    if not words:
        return ''

    depth = len(words) if ends_with_space else len(words) - 1
    current_word = '' if ends_with_space else words[-1]

    config = load_config(words[0])
    if config is None:
        return '\n'.join(file_candidates(cwd, current_word))

    node = navigate(config, words, depth)

    if node is None:
        return '\n'.join(file_candidates(cwd, current_word))

    if 'values' in node:
        return '\n'.join(node['values'])

    if 'command' in node:
        result = subprocess.run(node['command'], shell=True, capture_output=True, text=True)
        return result.stdout.strip()

    return '\n'.join(file_candidates(cwd, current_word))


def make_socket():
    listen_fds = int(os.environ.get('LISTEN_FDS', 0))
    if listen_fds >= 1:
        return socket.fromfd(SD_LISTEN_FDS_START, socket.AF_UNIX, socket.SOCK_STREAM)

    sock_path = os.path.join(
        os.environ.get('XDG_RUNTIME_DIR', '/tmp'), 'ag-completion.sock'
    )
    try:
        os.unlink(sock_path)
    except FileNotFoundError:
        pass
    sock = socket.socket(socket.AF_UNIX, socket.SOCK_STREAM)
    sock.bind(sock_path)
    sock.listen(5)
    return sock


def main():
    sock = make_socket()
    while True:
        conn, _ = sock.accept()
        try:
            chunks = []
            while True:
                chunk = conn.recv(4096)
                if not chunk:
                    break
                chunks.append(chunk)
            data = b''.join(chunks).decode()
            cwd, _, comp_line = data.partition('\n')
            conn.sendall(completions(cwd, comp_line).encode())
        finally:
            conn.close()


if __name__ == '__main__':
    main()
