#!/usr/bin/env python

verbose = True

import os
import sys
import re

if not len(sys.argv) > 1:
    print("No input file specified")
    sys.exit()

lineList = []
text = os.popen("ctags -x -f - {0}".format(sys.argv[1]))
for line in text:
    lineEntry = line.split()
    lineEntry[2] = int(lineEntry[2])
    lineList.append(lineEntry)

lineList.sort(key = lambda x: x[2])

macroList = []
variableList = []
enumList = []
structList = []
functionList = []
classList = []
memberDict = {}
mostRecentContainer = None
for lineColumns in lineList:
    name = lineColumns[0]
    rowType = lineColumns[1]
    lineNo = lineColumns[2]

    if rowType == "macro":
        macroList.append((name, lineNo))

    elif rowType == "variable":
        if verbose:
            declaration = " ".join(lineColumns[4:])
            if "=" in declaration:
                declaration = declaration.split("=")[0].rstrip() + ";"
            variableList.append((declaration, lineNo))
        else:
            variableList.append((name, lineNo))

    elif rowType == "enum":
        enumList.append((name, lineNo))
        mostRecentContainer = lineNo
        memberDict[lineNo] = []

    elif rowType == "struct":
        structList.append((name, lineNo))
        mostRecentContainer = lineNo
        memberDict[lineNo] = []

    elif rowType == "function":
        if verbose:
            declaration = " ".join(lineColumns[4:])
            if "(" in declaration:
                declaration = declaration.split("(")[0].rstrip() + ";"
            functionList.append((declaration, lineNo))
        else:
            functionList.append((name, lineNo))

    elif rowType == "enumerator":
        pass

    elif rowType == "member":
        memberDict[mostRecentContainer].append(name)

    elif rowType == "class":
        classList.append((name, lineNo))
        mostRecentContainer = lineNo
        memberDict[lineNo] = []

    else:
        print("")
        print("Unsupported type in ctags output: {0}".format(rowType))

variableList.sort(key = lambda x: x[1])
structList.sort(key = lambda x: x[1])
functionList.sort(key = lambda x: x[1])
classList.sort(key = lambda x: x[1])

print("")
print("MACROS")
for macro in macroList:
    print("    {0}".format(macro[0]))

print("")
print("VARIABLES")
for var in variableList:
    print("    {0}".format(var[0]))

print("")
print("ENUMERATIONS")
for enum,lineNo in enumList:
    print("    {0}".format(enum))
    if verbose:
        for member in memberDict[lineNo]:
            print("        {0}".format(member))

print("")
print("STRUCTS")
for struct,lineNo in structList:
    print("    {0}".format(struct))
    if verbose:
        for member in memberDict[lineNo]:
            print("        {0}".format(member))

print("")
print("FUNCTIONS")
for fcn in functionList:
    print("    {0}".format(fcn[0]))

print("")
print("CLASSES")
for cls,lineNo in classList:
    print("    {0}".format(cls))
    if verbose:
        for member in memberDict[lineNo]:
            print("        {0}".format(member))

print("")
























