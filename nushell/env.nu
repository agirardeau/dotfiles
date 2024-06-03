$env.CARGO_HOME = ($env.HOME | path join .cargo)
$env.HOMEBREW_PREFIX = /home/linuxbrew/.linuxbrew

$env.PATH = ($env.PATH
  | split row (char esep)
  | append /usr/local/bin
  | append ($env.HOME | path join bin)
  | append ($env.HOME | path join local-dotfiles bin)
  | append ($env.HOME | path join .local bin)
  | append ($env.CARGO_HOME | path join bin)
  | append ($env.HOMEBREW_PREFIX | path join bin)
  | append ($env.HOMEBREW_PREFIX | path join sbin)
  | uniq)
