# Generate ssh key if none exists
start-ssh-agent-or-exit() {
    if [[ ! $(pidof ssh-agent) ]]; then
        echo "[setup] No ssh-agent running, starting "
        eval "$(ssh-agent -s)"
        if ! ps -p $SSH_AGENT_PID > /dev/null; then
            exit 1
        fi
    fi
    return 0
}

if ! [ -f ~/.ssh/id_rsa ]; then
    echo "[setup] Creating ~/.ssh/id_rsa and adding it to ssh-agent..."
    if ! start-ssh-agent-or-exit; then
        echo "[setup] Unable to start ssh-agent. Exiting."
        exit 1
    fi
    mkdir ~/.ssh > /dev/null
    ssh-keygen -f ~/.ssh/id_rsa -t rsa -N ''
    ssh-add ~/.ssh/id_rsa
    link="https://help.github.com/articles/adding-a-new-ssh-key-to-your-github-account/"
    echo "[setup] Successfully created ssh key. Add it to you github account following $link."
    echo "[setup] Once added to githup, switch the local dotfiles repo to use ssl via:"
    echo "[setup]     git remote set-url origin git@github.com:agirardeaudale/dotfiles"
fi

