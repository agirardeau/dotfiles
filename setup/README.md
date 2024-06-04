# Setup Instructions

## 'Nix

### Dotfile setup

> NOTE - might make more sense to set up ssh, add the key to github, then pull
> down dotfiles. That would allow the dotfile repo to be private (and avoid
> having to run `git remote set-url` for it)
>
> That could probably be done with something like this (would want
> to move the ssh setup script from dotfiles to a bootstrap repo):
> 
> ```sh
> /bin/bash -c "$(curl -fsSL https://raw.githubusercontent.com/agirardeau/dotfiles/HEAD/setup/common/setup-ssh-agent.sh)"
> ```

* Clone repo:

  ```sh
  cd ~
  git clone https://github.com/agirardeau/dotfiles
  ```

* Generate symlinks:

  ```sh
  cd ~/dotfiles/setup
  ./dotfile-link-setup.py
  ```

  May need to delete existing default dotfiles from the distro, e.g.:

  ```sh
  rm ~/.bashrc ~/.profile
  ```

* Re-source everything:

  ```sh
  . ~/.bashrc
  ```

### SSH setup

* Setup agent, generate keys:

  ```sh
  cd ~/dotfiles/setup
  ./common/setup-ssh-agent.sh
  ```

* Setup ssh connection to github:

  ```sh
  cat ~/.ssh/id_rsa.pub
  ```

  Copy the printed key to github settings (as of May 2024, click avatar in upper
  right -> Settings -> SSH and GPG keys -> New SSH key).

  Update the dotfile repo to use ssh:

  ```sh
  git remote set-url origin git@github.com:agirardeau/dotfiles.git
  ```

  The first time running an operation against github using ssh an error message
  like the following will be printed, it should have no problems after that.

  ```
  The authenticity of host 'github.com (140.82.112.3)' can't be established.
  ED25519 key fingerprint is SHA256:+DiY3wvvV6TuJJhbpZisF/zLDA0zPMSvHdkr4UvCOqU.
  This key is not known by any other names.
  Are you sure you want to continue connecting (yes/no/[fingerprint])?
  ```

### Tool setup - Homebrew style

> EXPERIMENTAL

* Update system packages and get build tools (gcc, etc)

  ```sh
  sudo apt update
  sudo apt upgrade
  sudo apt install build-essential
  sudo apt install golang-go  # For jsonnet language tools
  sudo apt install python3-pip python3-venv  # For python development/language tools
  ```

* Homebrew

  Follow the instructions at https://docs.brew.sh/Homebrew-on-Linux#install. As
  of June 2024, this entails running the following:

  ```sh
  /bin/bash -c "$(curl -fsSL https://raw.githubusercontent.com/Homebrew/install/HEAD/install.sh)"
  ```

* Various utils

  ```sh
  brew install tree
  brew install ripgrep
  brew install ripgrep-all
  brew install fd
  brew install as-tree
  brew install fzf
  brew install unzip
  brew install node  # For javascript development + python/lua language tools
  ```

  Consider fzf setting up for nushell with
  https://github.com/nushell/nushell/issues/5785#issuecomment-1243733398

* Nushell

  ```sh
  brew install nushell
  ```

* Neovim

  ```sh
  brew install neovim
  ```

  To install mason packages, run:

  ```
  :AndrewMasonInstall [filetype]
  ```

* Rust/Cargo

  Follow instructions at https://www.rust-lang.org/tools/install. As of June
  2024, this entails running the following:

  ```sh
  curl https://sh.rustup.rs -sSf | sh
  ```

### Tool setup - Apt (older)

* Rust/Cargo

  ```sh
  # This doesn't use apt because it's desirable to have a per-user rustup that's
  # separate from system rustup
  #
  # In the installation options, choose custom installation and disable adding
  # path to .bashrc/.profile/.bash_profile, dotfiles already takes care of that.
  # May need to reload configurations with `refresh-rc`.
  curl https://sh.rustup.rs -sSf | sh
  ```

* C compiler

  ```sh
  sudo apt install clang
  ```

* Various utils

  ```sh
  sudo apt install tree
  sudo apt install ripgrep
  sudo apt install fd-find; mkdir -p ~/.local/bin; ln -s $(which fdfind) ~/.local/bin/fd
  cargo install -f --git https://github.com/jez/as-tree
  sudo apt install fzf
  ```

  To set up fzf completion and keybindings:

  ```sh
  git clone --depth 1 https://github.com/junegunn/fzf.git ~/.fzf
  ~/.fzf/install
  ```

  Consider fzf setting up for nushell with
  https://github.com/nushell/nushell/issues/5785#issuecomment-1243733398

* Nushell

  ```sh
  sudo apt install pkg-config libssl-dev
  cargo install nu
  ```

  > NOTE - It would be nice to install nushell as a binary rather than
  > compiling, but there isn't an ubuntu package. They recommend using
  > Homebrew or manually downloading the build executable.

* Neovim

  ```sh
  sudo add-apt-repository ppa:neovim-ppa/stable
  sudo apt update
  sudo apt install neovim
  ```

  Note that appimage might be encouraged over ppa in the future.

  To install mason packages, run:

  ```
  :AndrewMasonInstall [filetype]
  ```

## WSL

(In addition to 'nix setup)

### Directory setup

```sh
mkdir -p ~/truehome/links
mkdir -p ~/truehome/repos
cd ~/truehome/repos
git clone git@github.com:agirardeau/sandbox
```

### Win32Yank

> NOTE - I'm not sure if this is still necessary. I think the idea is to install
> neovim on Windows with scoop so that WSL can grab the version of win32yank it
> installs.

```bat
# Windows
scoop install [neovim?]
```

```sh
# WSL
ln -s /mnt/c/Users/Andrew/scoop/apps/neovim/current/Neovim/bin/win32yank.exe /usr/bin/win32yank
```

## OSX

See scripts in the `/setup/osx/` directory.

## Windows

### Scoop

See instructions at https://scoop.sh. As of May 2024, these state to run the
following in PowerShell:

```powershell
Set-ExecutionPolicy -ExecutionPolicy RemoteSigned -Scope CurrentUser
Invoke-RestMethod -Uri https://get.scoop.sh | Invoke-Expression
```

### Nushell

In `cmd`:

```bat
scoop install nu
```

### Neovim

```bat
scoop install neovim
```




