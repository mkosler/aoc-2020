#include <iostream>
#include <string>
#define _USE_MATH_DEFINES
#include <cmath>

struct Ship
{
  int X = 0;
  int Y = 0;
  int R = 0;
};

int main(int argc, char* argv[])
{
  Ship ship;

  for (std::string line; std::getline(std::cin, line); ) {
    auto action = line[0];
    auto magnitude = std::stoi(line.substr(1));

    // Being purposefully cursed here
    switch (action) {
      case 'S':
        magnitude = -magnitude;
      case 'N':
        ship.Y += magnitude;
        break;
      case 'W':
        magnitude = -magnitude;
      case 'E':
        ship.X += magnitude;
        break;
      case 'R':
        magnitude = -magnitude;
      case 'L':
        ship.R = ((ship.R + magnitude) % 360 + 360) % 360;
        break;
      case 'F':
        auto rad = (M_PI / 180) * ship.R;
        ship.X += magnitude * cos(rad);
        ship.Y += magnitude * sin(rad);
        break;
    }
  }

  std::cout << abs(ship.X) + abs(ship.Y) << std::endl;
}
