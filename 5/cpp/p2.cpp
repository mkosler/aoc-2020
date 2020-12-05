#include <iostream>
#include <string>
#include <cmath>
#include <array>

int bsp(int max, std::string pass, char lowKey, char highKey)
{
  auto mid = max / 2.0;
  auto diff = mid / 2.0;

  for (int i = 0; i < pass.size(); i++) {
    if (pass[i] == lowKey) mid -= diff;
    else if (pass[i] == highKey) mid += diff;

    diff /= 2;
  }

  return ceil(mid) - 1;
}

int main(int argc, char* argv[])
{
  std::array<bool, 1024> seats{ false };
  int minSeatId = 9999;

  for (std::string line; std::getline(std::cin, line); ) {
    auto rowStr = line.substr(0, 7);
    auto seatStr = line.substr(7);

    auto row = bsp(128, rowStr, 'F', 'B');
    auto seat = bsp(8, seatStr, 'L', 'R');

    auto id = row * 8 + seat;

    if (id < minSeatId) minSeatId = id;

    seats[id] = true;
  }

  for (int i = minSeatId; i < seats.size(); i++) {
    if (!seats[i + 1] && seats[i + 2]) {
      std::cout << "Missing seat: " << i + 1 << std::endl;
      return 0;
    }
  }

  return 0;
}
