#include <iostream>
#include <string>
#include <vector>
#include <algorithm>

const char FLOOR = '.';
const char EMPTY = 'L';
const char OCCUPIED = '#';

typedef std::vector<char> Row;
typedef std::vector<Row> Grid;

std::string gridToString(Grid grid)
{
  std::string s;

  for (auto r = 0; r < grid.size(); r++) {
    for (auto c = 0; c < grid[r].size(); c++) {
      s += grid[r][c];
    }
    s += '\n';
  }
  return s;
}

int countOccupiedNeighbors(Grid& grid, int r, int c)
{
  unsigned long int bounds[] = {
    (c - 1 < 0 ? 0 : (c - 1)), // left
    (c + 1 > grid[r].size() - 1 ? (grid[r].size() - 1) : (c + 1)), // right
    (r - 1 < 0 ? 0 : (r - 1)), // top
    (r + 1 > grid.size() - 1 ? (grid.size() - 1) : (r + 1)) // bottom
  };

  int count = 0;
  for (int nr = bounds[2]; nr <= bounds[3]; nr++) {
    for (int nc = bounds[0]; nc <= bounds[1]; nc++) {
      if (!(nr == r && nc == c) && grid[nr][nc] == OCCUPIED) count++;
    }
  }

  return count;
}

int applyRules(Grid& grid)
{
  Grid current = grid;

  auto change = 0;

  for (int r = 0; r < current.size(); r++) {
    for (int c = 0; c < current[r].size(); c++) {
      if (current[r][c] != FLOOR) {
        auto count = countOccupiedNeighbors(current, r, c);

        if (current[r][c] == EMPTY && count == 0) {
          change++;
          grid[r][c] = OCCUPIED;
        }

        if (current[r][c] == OCCUPIED && count >= 4) {
          change++;
          grid[r][c] = EMPTY;
        }
      }
    }
  }

  return change;
}

int main(int argc, char* argv[])
{
  Grid grid;

  for (std::string line; std::getline(std::cin, line); ) {
    Row row;

    for (const auto c : line) {
      row.push_back(c);
    }

    grid.push_back(row);
  }

  while (applyRules(grid) > 0) {
    std::cout << gridToString(grid) << std::endl;
  }

  auto sum = 0;
  for (const auto& row : grid) sum += std::count(row.begin(), row.end(), OCCUPIED);

  std::cout << "Occupied count: " << sum << std::endl;

  return 0;
}
