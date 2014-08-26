""" Andrew Girardeau-Dale
8/22/14

"""

################################## Imports ####################################

import os
import sys
import argparse
import pdb


################################# Utility ###################################

def englishJoin(stringList):
    """Join a list of strings using commas, spaces, and the word "and", as one
    would in English. Oxford comma is included.

    """

    if len(stringList) >= 2:
        return "{0}, and {1}".format(", ".join(stringList[:-1]), stringList[-1])
    elif len(stringList) == 1:
        return stringList[0];
    else:
        return "[]"


################################# Constants ###################################

files = {
    "vim" :
        [
            {
                "source" : "~/dotfiles/vim/vimrc",
                "link"   : "~/.vimrc"
            },
            {
                "source" : "~/dotfiles/vim/python.vim",
                "link"   : "~/.vim/python.vim"
            },
            {
                "source" : "~/dotfiles/vim/solarized.vim",
                "link"   : "~/.vim/colors/solarized.vim"
            },
        ],

    "git" :
        [
            {
                "source" : "~/dotfiles/git/gitconfig",
                "link"   : "~/.gitconfig"
            },
            {
                "source" : "~/dotfiles/git/gitignore",
                "link"   : "~/.gitignore"
            },
        ],

    "bash" :
        [
            {
                "source" : "~/dotfiles/bash/bashrc",
                "link"   : "~/.bashrc"
            },
            {
                "source" : "~/dotfiles/bash/bash_aliases",
                "link"   : "~/.bash_aliases"
            },
            {
                "source" : "~/dotfiles/bash/dircolors",
                "link"   : "~/.dircolors"
            },
        ],

    "tmux" :
        [
            {
                "source" : "~/dotfiles/tmux/tmux.conf",
                "link"   : "~/.tmux.conf"
            },
        ],

}

potentialGroups = files.keys()
potentialGroupString = englishJoin(['"{0}"'.format(x) for x in potentialGroups])

home = os.path.expanduser("~")

################################# Functions ###################################

def createLinks(fileList):
    for file in fileList:
        source = file["source"].replace("~", home, 1)
        link = file["link"].replace("~", home, 1)
        (linkDirectory, _) = os.path.split(link)
        try:
            os.makedirs(linkDirectory)
        except:
            pass
        if os.path.lexists(link):
            try:
                os.mkdir("{0}/dotfiles_old".format(home))
            except:
                pass
            os.renames(link, "{0}/dotfiles_old/{1}".format(home, file["link"][2:]))
        os.symlink(source, link)

################################ Control FLow #################################

def getArgumentParser():
    """Construct a command line argument parser.
    
    Returns:
        argParser (argparse.ArgumentParser).
    
    """

    argParser = argparse.ArgumentParser(
            prog="Make links in home directory to dotfiles in repo folder")
    
    helpString = ("Groups of dotfiles to create links for. Options are {0}. "
            "If left blank, all groups will be linked."
            ).format(potentialGroupString)
    argParser.add_argument("groups", nargs="*", metavar="groups",
            help=helpString)
    
    argParser.add_argument("-q", "--quiet", const=True, default=False,
            nargs="?", metavar="quiet mode", dest="quiet",
            help="Suppress program status printing.")

    return argParser

#################################### Main #####################################

def main(argList):

    argParser = getArgumentParser()
    args = argParser.parse_args(argList)

    groups = []
    if not args.groups:
        groups = potentialGroups
    else:
        groups = args.groups
        for group in groups:
            if group not in potentialGroups:
                raise ValueError('Group "{0}" not recognized. Options are {1}.'
                        .format(group, potentialGroupString))
    
    # wasErrorRaised = False
    # try:
    for group in groups:
        createLinks(files[group])
    # except Exception as error:
    #     wasErrorRaised = True
    #     raisedError = error
    # finally:
    #     pass
        
    # if wasErrorRaised:
    #     raise raisedError
    # else:
    #     if not args.quiet:
    #         print("Log file contents parsed successfully")

if __name__ == "__main__":
    # try:
    main(sys.argv[1:])
    # except Exception as E:
    #     print("{0}: {1}".format(E.__class__.__name__, E))


