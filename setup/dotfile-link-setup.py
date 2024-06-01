#!/usr/bin/env python3

import os
import json
import platform

HOME = os.path.expanduser("~")
LINK_FILE = os.path.join(os.path.dirname(os.path.realpath(__file__)), "links.json")
NODE_NAME = platform.node()
XDG_CACHE_HOME_DEFAULT = "~/.cache"
STATE_FILENAME = "dotfile-link-state.json"

def update_link(link, target):
    """Returns True if after execution a link exists, regardless of if it
    points to the intended target. The link will be pointing to the wrong
    target only if the operation to remove an existing link failed.
    """
    if os.path.lexists(link) and os.path.islink(link):
        if os.readlink(link) == target:
            return True
        else:
            try:
                remove_link(link)
            except:
                return True

    try:
        create_link(link, target)
    except:
        return False

    return True

def create_link(link, target):
    (link_directory, _) = os.path.split(link)

    if not os.path.exists(target):
        print("No file to link to at {0}".format(target))
        raise IOError()

    try:
        os.makedirs(link_directory)
    except:
        pass

    try:
        os.symlink(target, link)
    except OSError as e:
        print("Unable to create link for {0} at {1}: {2}"
                .format(target, link, str(e)))
        raise

    print("Created link for {0} at {1}".format(target, link))

def remove_link(link):
    try:
        os.unlink(link)
        print("Removed obsolete link at {0}".format(link))
    except OSError as e:
        print("Unable to remove obsolete link at {0}: {1}".format(link, str(e)))
        raise

def load_link_data():
    with open(LINK_FILE, "r") as f:
        link_data = json.load(f)

    return {x : [[replace_tilde(a[0]), replace_tilde(a[1])] for a in link_data[x]]
            for x in link_data}

def replace_tilde(path_string):
    return path_string.replace("~", HOME, 1)

if __name__ == "__main__":
    xdg_cache_home = replace_tilde(os.getenv("XDG_CACHE_HOME", XDG_CACHE_HOME_DEFAULT))
    try:
        os.makedirs(xdg_cache_home)
    except:
        pass
    state_file = os.path.join(xdg_cache_home, STATE_FILENAME)

    new_state = []
    try:
        with open(state_file, "r") as f:
            previous_state = json.load(f)
    except:
        previous_state = []

    link_data = load_link_data()

    print("")
    print("Constructing common links...")
    for target, link in link_data["common"]:
        if update_link(link, target):
            new_state.append(link)

    if NODE_NAME in link_data:
        print("")
        print("Constructing links specific to {0}...".format(NODE_NAME))
        for target, link in link_data[NODE_NAME]:
            if update_link(link, target):
                new_state.append(link)

    print("")
    for link in previous_state:
        if link not in [x[1] for x in link_data["common"] + link_data.get(NODE_NAME, [])]:
            if os.path.lexists(link):
                try:
                    remove_link(link)
                except:
                    new_state.append(link)

    with open(state_file, "w") as f:
        json.dump(new_state, f)
