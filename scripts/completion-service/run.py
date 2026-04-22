#!/usr/bin/env python3

# ag completion service daemon
# Listens on a Unix socket (via systemd socket activation or self-bound fallback),
# reads COMP_LINE from each connection, writes completions back.

import os
import socket

SD_LISTEN_FDS_START = 3


def completions(line):
    raw = line.rstrip('\n')
    ends_with_space = raw.endswith(' ')
    words = [w for w in raw.strip().split() if w]

    depth = len(words) if ends_with_space else len(words) - 1

    if depth == 1:
        return 'repo'
    if depth == 2:
        if len(words) > 1 and words[1] == 'repo':
            return 'create'
        return ''
    return ''


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
            line = b''.join(chunks).decode()
            conn.sendall(completions(line).encode())
        finally:
            conn.close()


if __name__ == '__main__':
    main()
