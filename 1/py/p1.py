import sys

expenses = []

for line in sys.stdin:
    expenses.append(int(line))

for a in expenses:
    for b in expenses:
        if a != b and a + b == 2020:
            print(a, b, a * b)
            quit()
