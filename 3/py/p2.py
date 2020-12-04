import sys

routeMap = []

for line in sys.stdin:
    row = []

    for c in line.rstrip():
        row.append(c == "#")

    routeMap.append(row)

width = len(routeMap[0])
height = len(routeMap)

velocities = [
    { "dr": 1, "dc": 1 },
    { "dr": 1, "dc": 3 },
    { "dr": 1, "dc": 5 },
    { "dr": 1, "dc": 7 },
    { "dr": 2, "dc": 1 },
]

answer = 1

for velocity in velocities:
    pos = { "r": 0, "c": 0 }
    treeCount = 0

    while pos["r"] < height:
        pos["r"] += velocity["dr"]
        pos["c"] = (pos["c"] + velocity["dc"]) % width

        if pos["r"] >= height:
            break

        if routeMap[pos["r"]][pos["c"]]:
            treeCount += 1

    answer *= treeCount

print("answer", answer)
