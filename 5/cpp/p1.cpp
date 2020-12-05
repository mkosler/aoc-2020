#include <iostream>
#include <string>
#include <cmath>

int bsp(int max, std::string pass, char lowKey, char highKey)
{
  auto mid = max / 2;
  auto diff = mid / 2;

  for (int i = 0; i < pass.size(); i++) {
    if (pass[i] == lowKey) mid -= diff;
    else if (pass[i] == highKey) mid += diff;

    diff /= 2;
  }

  return ceil(mid) - 1;
}

int main(int argc, char* argv[])
{
  int maxSeatId = -1;

  for (std::string line; std::getline(std::cin, line); ) {
    auto rowStr = line.substr(0, 7);
    auto seatStr = line.substr(7);

    auto row = bsp(128, rowStr, 'F', 'B');
    auto seat = bsp(8, seatStr, 'L', 'R');

    auto id = row * 8 + seat;

    if (id > maxSeatId) maxSeatId = id;
  }

  std::cout << "max seat id: " << maxSeatId << std::endl;

  return 0;
}
