#include <iostream>
#include <string>
#define _USE_MATH_DEFINES
#include <cmath>

struct Point
{
  double X;
  double Y;
};

int main(int argc, char* argv[])
{
  Point ship{0, 0};
  Point waypoint{10, 1};

  for (std::string line; std::getline(std::cin, line); ) {
    auto action = line[0];
    auto magnitude = std::stoi(line.substr(1));

    if (action == 'N') {
      waypoint.Y += magnitude;
    } else if (action == 'S') {
      waypoint.Y -= magnitude;
    } else if (action == 'E') {
      waypoint.X += magnitude;
    } else if (action == 'W') {
      waypoint.X -= magnitude;
    } else if (action == 'L' || action == 'R') {
      if (action == 'R') magnitude = -magnitude;

      auto rad = (M_PI / 180.0) * magnitude;
      auto nx = waypoint.X * cos(rad) - waypoint.Y * sin(rad);
      auto ny = waypoint.X * sin(rad) + waypoint.Y * cos(rad);
      waypoint.X = nx;
      waypoint.Y = ny;
    } else if (action == 'F') {
      ship.X += magnitude * waypoint.X;
      ship.Y += magnitude * waypoint.Y;
    }
  }

  std::cout << abs(ship.X) + abs(ship.Y) << std::endl;
}
