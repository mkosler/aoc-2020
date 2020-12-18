#ifndef __CONWAY_H__
#define __CONWAY_H__

#include <vector>
#include <string>
#include <set>
#include <sstream>

struct CubeState
{
  std::string Cube;
  bool State;
  int X;
  int Y;
  int Z;
};

class Conway3d
{
  private:
    std::set<std::string> _activeCubes;
    private int _minX = -1;
    private int _maxX;
    private int _minY = -1;
    private int _maxY;
    private int _minZ = -1;
    private int _maxZ = 1;

    std::string CoordsToString(int x, int y, int z)
    {
      std::stringstream ss;
      ss << x << "," << y << "," << z;
      return ss.str();
    }

    unsigned int GetActiveNeighborCount(int cx, int cy, int cz)
    {
      unsigned int count = 0;

      for (int x = -1; x <= 1; x++) {
        for (int y = -1; y <= 1; y++) {
          for (int z = -1; z <= 1; z++) {
            if (!(x == 0 && y == 0 && z == 0)) {
              if (_activeCubes[CoordsToString(cx + x, cy + y, cz + z)] != _activeCubes.end()) {
                count++;
              }
            }
          }
        }
      }

      return count;
    }

  public:
    Conway3d() {}

    void Cycle()
    {
      std::vector<CubeState> changes;

      for (int x = _minX; x <= _maxX; x++) {
        for (int y = _minY; y <= _maxY; y++) {
          for (int z = _minZ; z <= _maxZ; z++) {
            auto activeNeighbors = GetActiveNeighborCount(x, y, z);
            auto str = CoordsToString(x, y, z);

            if (_activeCubes[str] != _activeCubes.end()) {
              if (!(activeNeighbors == 2 || activeNeighbors == 3)) {
                changes.push_back(CubeState{str, false, x, y, z});
              }
            } else {
              if (activeNeighbors == 3) {
                changes.push_back(CubeState{str, true, x, y, z});
              }
            }
          }
        }
      }

      for (const auto& v : changes) {
        if (!v.State) {
          _activeCubes.erase(v.Cube);
        } else {
          _activeCubes.insert(v.Cube);

          if (v.X == _minX) _minX = v.X - 1;
          if (v.Y == _minY) _minY = v.Y - 1;
          if (v.Z == _minZ) _minZ = v.Z - 1;

          if (v.X == _maxX) _maxX = v.X + 1;
          if (v.Y == _maxY) _maxY = v.Y + 1;
          if (v.Z == _maxZ) _maxZ = v.Z + 1;
        }
      }
    }
};

#endif
