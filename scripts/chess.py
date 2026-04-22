#!/usr/bin/env python3

import itertools
import random
import timeit

def file_letter(file):
    return chr(file + 96)

print("")
print("Answer whether a random square is light or dark!")

aliases = {'l': 'light', 'd': 'dark'}
oldsquare = ''

class Square:
    def __init__(self, rank, file):
        self.rank = rank
        self.file = file

    def name(self):
        return f"{file_letter(self.file)}{self.rank}"

    def color(self):
        return 'light' if (self.rank + self.file) % 2 else 'dark'

    def __repr__(self):
        return f'[{self.name()}]'

squares = [Square(r, f) for r, f in itertools.product(range(1, 9), range(1, 9))]
queue = random.sample(squares, 64)

t1 = timeit.default_timer()
while queue:
    square = queue.pop(0)
    answer = input(f"Sqaure - {square.name()}: ")
    if aliases.get(answer, answer) == square.color():
        print("Correct!")
    else:
        print(f"Incorrect, {square.name()} is a {square.color()} square")
        queue.append(square)
    print("")

t2 = timeit.default_timer()
print(f'Finished all squares in {t2-t1:1f} seconds!')
print("")

