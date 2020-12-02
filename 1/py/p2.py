import sys

expenses = []

for line in sys.stdin:
    expenses.append(int(line))

for a in expenses:
    for b in expenses:
        for c in expenses:
            if a != b and a != c and b != c and a + b + c == 2020:
                print(a, b, c, a * b * c)
                quit()
