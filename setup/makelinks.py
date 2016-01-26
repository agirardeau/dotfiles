#!/usr/bin/env python

import os
import json
import platform

HOME = os.path.expanduser("~")
LINKFILE = os.path.abspath(os.path.join(os.path.dirname(__file__), "links.json"))
NODENAME = platform.node()

def make_link(source, target):
    target = target.replace("~", HOME, 1)
    source = source.replace("~", HOME, 1)
    (source_directory, _) = os.path.split(source)

    if not os.path.exists(target):
        print("No file to link to at {0}".format(target))
        return

    try:
        os.makedirs(source_directory)
    except:
        pass

    if os.path.lexists(source):
        try:
            os.unlink(source)
        except OSError as e:
            print("Couldn't remove existing link at {0}: {1}"
                    .format(source, str(e)))
            return

    try:
        os.symlink(target, source)
    except OSError as e:
        print("Error linking {0} to {1}: {2}"
                .format(source, target, str(e)))
        return

    print("Created link for {0} at {1}".format(target, source))

if __name__ == "__main__":
    with open(LINKFILE, "r") as f:
        link_data = json.load(f)

    print("Constructing common links...")
    for target, source in link_data["common"]:
        make_link(source, target)

    if NODENAME in link_data:
        print("Constructing links specific to {0}...".format(NODENAME))
        for target, source in link_data[NODENAME]:
            make_link(source, target)
