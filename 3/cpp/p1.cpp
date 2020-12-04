#include <iostream>
#include <string>
#include <vector>

int main(int argc, char* argv[])
{
  std::vector<std::vector<bool>> map;

  for (std::string line; std::getline(std::cin, line); ) {
    std::vector<bool> row;

    for (auto i = 0; i < line.size(); i++) {
      row.push_back(line[i] == '#');
    }

    map.push_back(row);
  }

  int width = map[0].size();
  int height = map.size();

  int pos[] = { 0, 0 };
  int vel[] = { 1, 3 };
  int treeCount = 0;

  while (pos[0] < height) {
    pos[1] = (pos[1] + vel[1]) % width;
    pos[0] += vel[0];

    if (pos[0] >= height) break;

    if (map[pos[0]][pos[1]]) treeCount++;
  }

  std::cout << "treeCount " << treeCount << std::endl;

  return 0;
}
