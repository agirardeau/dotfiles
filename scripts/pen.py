#!/usr/bin/env python3
import argparse
import datetime
import os
import re
import subprocess
import sys

CATEGORY_TO_DIRECTORY = {
    'draft': '~/truehome/notesync/tmp/drafts',
    'thoughts': '~/truehome/notesync/personal/thoughts',
    'journal': '~/truehome/notesync/personal/journal',
    'notes': '~/truehome/notesync/endeavors/notes',
    'tmp': '~/truehome/notesync/tmp'}
DICTIONARY_TO_CATEGORY = {v: k for k, v in CATEGORY_TO_DIRECTORY.items()}

def new(argv):
    parser = argparse.ArgumentParser(description='new entry')
    parser.add_argument('category', choices=CATEGORY_TO_DIRECTORY.keys())
    parser.add_argument('name', type=validate_entry_name)
    args = parser.parse_args(argv)

    #directory = CATEGORY_TO_DIRECTORY[args.category]
    #datestring = datetime.date.today().strftime('%Y%m%d')
    #filename = f'{args.category}-{datestring}-{args.name}'
    #
    #fullname = os.path.join(directory, filename)
    #print(f'Opening {fullname} for writing...')
    #subprocess.call(f'nvim {fullname}', shell=True)

    entry = Entry(args.category, datetime.date.today(), args.name)
    #print(f'Opening {entry.get_fullpath()} for writing...')
    #subprocess.call(f'nvim {entry.get_fullpath()}', shell=True)
    entry.open()


def edit(argv):
    parser = argparse.ArgumentParser(description='edit entry')
    parser.add_argument('category', choices=CATEGORY_TO_DIRECTORY.keys())
    parser.add_argument('name', type=validate_entry_name)
    args = parser.parse_args(argv)

    entry = get_entry_by_name_with_disambiguation(args.category, args.name)
    #print(f'Opening {entry.get_fullpath()} for editing...')
    #subprocess.call(f'nvim {entry.get_fullpath()}', shell=True)
    entry.open()

def list(argv):
    parser = argparse.ArgumentParser(description='list entries')
    parser.add_argument('category', choices=CATEGORY_TO_DIRECTORY.keys())
    args = parser.parse_args(argv)

    print(f'Entries for {args.category}:')
    for entry in get_entries_for_category(args.category):
        print(entry.to_date_name_string())

    #directory = CATEGORY_TO_DIRECTORY[args.category]
    #print(f'Files in {directory}:')
    #subprocess.call(f'ls -l {directory}', shell=True)

def delete(argv):
    parser = argparse.ArgumentParser(description='delete entry')
    parser.add_argument('category', choices=CATEGORY_TO_DIRECTORY.keys())
    parser.add_argument('name', type=validate_entry_name)
    args = parser.parse_args(argv)

    entry = get_entry_by_name_with_disambiguation(args.category, args.name)
    print(f'Deleting {entry.get_fullpath()}...')
    os.remove(entry.get_realpath())

def cat(argv):
    parser = argparse.ArgumentParser(description='print entry')
    parser.add_argument('category', choices=CATEGORY_TO_DIRECTORY.keys())
    parser.add_argument('name', type=validate_entry_name)
    args = parser.parse_args(argv)

    entry = get_entry_by_name_with_disambiguation(args.category, args.name)
    subprocess.call(f'cat {entry.get_fullpath()}', shell=True)

def mv(argv):
    print('mv not implemented yet.')

def cd(argv):
    # Can't implement? python subprocess can't change directory of parent process
    print('cd not implemented yet.')

def categories(argv):
    for category, directory in CATEGORY_TO_DIRECTORY.items():
        print(f'{category:12} | {directory}')

def get_entry_by_name_with_disambiguation(category, name):
    entries = [x for x in get_entries_for_category(category) if x.name == name]
    if len(entries) == 0:
        print(f'No {category} entry with name {name}.')
        sys.exit()
    elif len(entries) == 1:
        return entries[0]
    else:
        for index, entry in enumerate(entries):
            print(f'{index+1}) {entry.to_date_name_string()}')
        selection = int(input())
        return entries[selection-1]

def get_entries_for_category(category):
    directory = CATEGORY_TO_DIRECTORY[category]
    filenames = os.listdir(os.path.expanduser(directory))

    # Would love to use a list comprehension here but that
    # won't let me filter out exceptions
    entries = []
    for filename in filenames:
        try:
            entries.append(Entry.from_filename(filename))
        except ValueError:
            pass
    return reversed(entries)

def validate_entry_name(name):
    if re.fullmatch('[-\w]+', name) is None:
        raise ValueError(f'Name \'{name}\' contains non-word characters.')
    return name

class Entry:
    FILENAME_RE = re.compile('(?P<category>\w+)-(?P<datestr>\d+)-(?P<name>[-\w]+)')

    def __init__(self, category, date, name):
        self.category = category
        self.date = date
        self.name = name

    @staticmethod
    def from_filename(filename):
        match = Entry.FILENAME_RE.fullmatch(filename)
        if match is None:
            raise ValueError(f'Filename \'{filename}\' does not match expected format.')

        category = match.group('category')
        date = datetime.datetime.strptime(match.group('datestr'), '%Y%m%d').date()
        name = match.group('name')

        return Entry(category, date, name)

    def get_filename(self):
        return f"{self.category}-{self.date.strftime('%Y%m%d')}-{self.name}"

    def get_fullpath(self):
        directory = CATEGORY_TO_DIRECTORY[self.category]
        return os.path.join(directory, self.get_filename())

    def get_realpath(self):
        return os.path.expanduser(self.get_fullpath())

    def to_date_name_string(self):
        return f"{self.date.strftime('%b %d, %Y (%a)')}: {self.name}"

    def open(self):
        print(f'Opening {self.get_fullpath()} for writing...')
        os.chdir(os.path.expanduser(CATEGORY_TO_DIRECTORY[self.category]))
        subprocess.call(f'nvim {self.get_filename()}', shell=True)


SUBCOMMANDS = {
    'new': new,
    'edit': edit,
    'list': list,
    'delete': delete,
    'cat': cat,
    'mv': mv,
    'cd': cd,
    'categories': categories}

if __name__ == '__main__':
    parser = argparse.ArgumentParser(description='Manage writing artifacts')
    parser.add_argument('subcommand', choices=SUBCOMMANDS.keys())
    parser.add_argument('subcommand_args', nargs='*')
    args = parser.parse_args()
    SUBCOMMANDS[args.subcommand](args.subcommand_args)





