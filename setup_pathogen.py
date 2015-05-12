#!/usr/bin/env python

import os
import shutil
import urllib2

pathogenUrl = "https://raw.githubusercontent.com/tpope/vim-pathogen/master/autoload/pathogen.vim"

home = os.path.expanduser("~")
def relhome(path):
    return os.path.join(home, path)
    
print("Deleting existing ~/.vim folder...")
try:
    shutil.rmtree(relhome(".vim"))
except OSError:
    pass

print("Setting up file structure...")
os.mkdir(relhome(".vim"))
os.mkdir(relhome(".vim/autoload"))
os.mkdir(relhome(".vim/bundle"))

print("Downloading latest version of pathogen.vim...")
f = open(relhome(".vim/autoload/pathogen.vim"), "w")
try:
    pathogen = urllib2.urlopen(pathogenUrl, timeout=5).read()
    print("got stuff")
    print(pathogen)
    f.write(pathogen)
finally:
    print("Failed to download pathogen.")
    f.close()
    
