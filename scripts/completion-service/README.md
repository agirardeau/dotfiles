# Completion Service

A Unix socket daemon that provides tab completions for shell commands. It is invoked by the `ag-completion-service` systemd socket unit and driven by per-command TOML config files.

## How It Works

The bash completion function `_query_completion_service` sends `{PWD}\n{COMP_LINE}` to the socket and receives newline-separated completion candidates. The daemon reads the command name from `COMP_LINE`, loads the corresponding config file, and returns the appropriate candidates.

If no config file exists for the command, or if the current subcommand path has no config entry, the daemon falls back to listing files in the user's working directory.

## Config File Format

Config files live at `scripts/completion-service/config/{COMMAND}.toml`.

### Top-level keys

- `[root]` — completions for the first argument after the command
- `[subcommands.NAME]` — completions when `NAME` was the previous argument
- `[subcommands.NAME.subcommands.SUBNAME]` — deeper nesting, arbitrarily deep

### Completion sources (per node)

Each node must have exactly one of:

| Key | Type | Description |
|-----|------|-------------|
| `values` | array of strings | Static list of candidates |
| `command` | string | Shell command whose stdout (one item per line) provides candidates |

If a node has neither key, file-based completion is used for that position.

### Fallback behavior

When no config node matches the current position (unknown subcommand, or node with no `values`/`command`), the service lists entries in the user's current working directory that match the partial word typed.

## Examples

### Static values

```toml
[root]
values = ["repo"]

[subcommands.repo]
values = ["create", "list"]

[subcommands.repo.subcommands.create]
# no values/command → file-based completion
```

### Shell command

```toml
[root]
command = "for f in $HOME/.screenlayout/*.sh; do basename \"$f\" .sh; done"
```

## Adding a New Command

1. Create `config/{COMMAND}.toml` with the desired structure.
2. Register the command in `bash/completions`:
   ```bash
   complete -F _query_completion_service COMMAND
   ```
3. Restart the service: `systemctl --user restart ag-completion-service`
