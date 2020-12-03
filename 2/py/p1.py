import sys, re

validPasswords = 0

fullfile = sys.stdin.read()

for (min, max, letter, password) in re.findall(r"(\d+)-(\d+)\s+(\w):\s+(\w+)", fullfile):
    count = password.count(letter)

    if int(min) <= count and count <= int(max):
        validPasswords += 1

print('validPasswords', validPasswords)
