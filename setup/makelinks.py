#!/usr/bin/env python

import os
import json
import platform

HOME = os.path.expanduser("~")
LINK_FILE = os.path.join(os.path.dirname(os.path.realpath(__file__)), "links.json")
NODE_NAME = platform.node()
XDG_DATA_HOME_DEFAULT = "~/.local/share"

def update_link(link, target):
    """Returns True if after execution a link exists (regardless of if it
    points to the intended target)
    """
    target = target.replace("~", HOME, 1)
    link = link.replace("~", HOME, 1)
    if os.path.lexists(link):
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
    target = target.replace("~", HOME, 1)
    link = link.replace("~", HOME, 1)
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
    link = link.replace("~", HOME, 1)
    try:
        os.unlink(link)
        print("Removed obsolete link at {0}")
    except OSError as e:
        print("Unable to remove obsolete link at {0}: {1}"
                .format(link, str(e)))
        raise

if __name__ == "__main__":
    xdg_data_home = os.getenv("XDG_DATA_HOME", XDG_DATA_HOME_DEFAULT).replace("~", HOME, 1)
    try:
        os.makedirs(xdg_data_home)
    except:
        pass
    state_file = os.path.join(xdg_data_home, "makelinks-state.json")

    new_state = []
    try:
        with open(state_file, "r") as f:
            previous_state = json.load(f)
    except:
        previous_state = []

    with open(LINK_FILE, "r") as f:
        link_data = json.load(f)

    print("Constructing common links...")
    for target, link in link_data["common"]:
        if update_link(link, target):
            new_state.append(link)

    if NODE_NAME in link_data:
        print("Constructing links specific to {0}...".format(NODE_NAME))
        for target, link in link_data[NODE_NAME]:
            if update_link(link, target):
                new_state.append(link)

    for link in previous_state:
        if link not in [x[1] for x in link_data["common"] + link_data[NODE_NAME]]:
            if os.path.lexists(link):
                delete_link(link)

    with open(state_file, "w") as f:
        json.dump(new_state, f)
