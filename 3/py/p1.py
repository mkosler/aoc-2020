import sys

routeMap = []

for line in sys.stdin:
    row = []

    for c in line.rstrip():
        row.append(c == "#")

    routeMap.append(row)

width = len(routeMap[0])
height = len(routeMap)

pos = { "r": 0, "c": 0 }
velocity = { "dr": 1, "dc": 3 }
treeCount = 0

while pos["r"] < height:
    pos["r"] += velocity["dr"]
    pos["c"] = (pos["c"] + velocity["dc"]) % width

    if pos["r"] >= height:
        break

    if routeMap[pos["r"]][pos["c"]]:
        treeCount += 1

print("treeCount", treeCount)
