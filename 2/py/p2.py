import sys, re

validPasswords = 0

fullfile = sys.stdin.read()

for (p1, p2, letter, password) in re.findall(r"(\d+)-(\d+)\s+(\w):\s+(\w+)", fullfile):
    p1, p2 = int(p1), int(p2)

    count = 0

    if password[p1 - 1] == letter:
        count += 1
    if password[p2 - 1] == letter:
        count += 1

    if count == 1:
        validPasswords += 1

print('validPasswords', validPasswords)
