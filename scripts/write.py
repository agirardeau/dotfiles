#!/usr/bin/env python3
import argparse
import datetime
import os
import subprocess
import sys

def new(argv):
    parser = argparse.ArgumentParser(description="new file")
    parser.add_argument("category", choices=locations.keys())
    parser.add_argument("name")

    args = parser.parse_args(argv)
    directory = locations[args.category]
    datestring = datetime.date.today().strftime('%y%m%d')
    filename = f"{args.category}-{datestring}-{args.name}"
    
    subprocess.call(["nvim", os.path.join(directory, filename)])

def edit(argv):
    print("Edit not implemented yet.")

def list(argv):
    parser = argparse.ArgumentParser(description="new file")
    parser.add_argument("category", choices=locations.keys())

    args = parser.parse_args(argv)
    directory = locations[args.category]

    #subprocess.call(["ls", directory])

    subprocess.call(f"ls -l {directory}", shell=True)

def delete(argv):
    print("Delete not implemented yet.")

subcommands = {
    "new": new,
    "edit": edit,
    "list": list}

locations = {
    "draft": "~/notesync/tmp/drafts",
    "chrono": "~/notesync/chrono",
    "tmp": "~/notesync/tmp"}

parser = argparse.ArgumentParser(description="Manage writing artifacts")
parser.add_argument("subcommand", choices=subcommands.keys())
parser.add_argument("subcommand_args", nargs="*")
args = parser.parse_args()
subcommands[args.subcommand](args.subcommand_args)







