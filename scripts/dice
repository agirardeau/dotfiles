#!/usr/bin/env python3

import random
import sys

for arg in sys.argv[1:]:
    foo = arg.split('+')
    die = int(foo[0])
    modifier = int(foo[1]) if len(foo) > 1 else 0
    roll = random.randint(1, die)
    print("{} ({})".format(roll + modifier, roll))
