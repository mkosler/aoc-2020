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

bool testNearestNeighbor(Grid& grid, int cr, int cc, int dr, int dc)
{
  if (cr < 0 || cc < 0 || cr > grid.size() - 1 || cc > grid[cr].size() - 1) return false;
  if (grid[cr][cc] != FLOOR) return grid[cr][cc] == OCCUPIED;
  return testNearestNeighbor(grid, cr + dr, cc + dc, dr, dc);
}

int countOccupiedNeighbors(Grid& grid, int r, int c)
{
  auto count = 0;

  for (auto dr = -1; dr <= 1; dr++) {
    for (auto dc = -1; dc <= 1; dc++) {
      if (!(dr == 0 && dc == 0) && testNearestNeighbor(grid, r + dr, c + dc, dr, dc)) count++;
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

        if (current[r][c] == OCCUPIED && count >= 5) {
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
