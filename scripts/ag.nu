#!/usr/bin/env nu

# Personal dev environment utilities
def main [] {
    help main
}

# Manage GitHub repositories
def "main repo" [] {
    help "main repo"
}

# Create a new GitHub repository and clone it locally
def "main repo create" [
    name: string   # Repository name
    --public       # Make the repository public (default: private)
] {
    let visibility = if $public { "--public" } else { "--private" }
    let repo_dir = ($env.HOME | path join "truehome" "repos" $name)
    let clone_path = ($repo_dir | path join "main")
    let repo_url = $"git@github.com:agirardeau/($name).git"

    mkdir $repo_dir

    gh repo create $name $visibility
    git clone $repo_url $clone_path

    cd $clone_path
    touch README.md
    git add README.md
    git commit -m "Initial commit"
    git push --set-upstream origin main
}
