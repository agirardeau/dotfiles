# Setup Instructions

## Unix

### Dotfile setup

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

### Get miscellaneous tools

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
  :AndrewMasonInstall
  ```

## WSL

In addition to the Unix setup, set up win32yank:

```sh
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

