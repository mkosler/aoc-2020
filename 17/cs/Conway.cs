using System;
using System.Collections.Generic;

namespace cs
{
  public interface IConway
  {
    void Cycle();
    void SetInitialState(string initialState);
  }

  public class Conway3d : IConway
  {
    private (int Min, int Max) _boundX;
    private (int Min, int Max) _boundY;
    private (int Min, int Max) _boundZ = (-1, 1);
    private HashSet<string> _activeCubes = new HashSet<string>();

    public Conway3d()
    {
    }

    public void Cycle()
    {
      var changes = new List<dynamic>();

      for (var x = _boundX.Min; x <= _boundX.Max; x++) {
        for (var y = _boundY.Min; y <= _boundY.Max; y++) {
          for (var z = _boundZ.Min; z <= _boundZ.Max; z++) {
            var activeNeighborCount = GetActiveNeighborCount(x, y, z);
            var str = $"{x},{y},{z}";

            if (activeCubes.Contains(str) && !(activeNeighborCount == 2 || activeNeighborCount == 3)) {
              changes.Add(new { Cube = str, State = false, X = x, Y = y, Z = z });
            } else if (!activeCubes.Contains(str) && activeNeighborCount == 3) {
              changes.Add(new { Cube = str, State = true, X = x, Y = y, Z = z });
            }
          }
        }
      }

      for (dynamic c in changes) {
        if (!c.State) _activeCubes.Remove(v.Cube);
        else {
          _activeCubes.Add(v.Cube);
        }

        /* if (c.State) _activeCubes.Add(v.Cube); */
        /* else _activeCubes.Remove(v.Cube); */
      }
    }

    public void SetInitialState(string initialState)
    {
      _activeCubes = new HashSet<string>();
      var x = 0;
      var y = 0;

      foreach (var c in initialState)
      {
        if (c == '#') _activeCubes.Add($"{x},{y},0");

        x++;
        if (c == '\n') {
          x = 0;
          y++;
        }
      }

      _boundX = (-1, x);
      _boundY = (-1, y + 1);
    }

    private int GetActiveNeighborCount(int cx, int cy, int cz)
    {
      var count = 0;

      for (var x = -1; x <= 1; x++) {
        for (var y = -1; y <= 1; y++) {
          for (var z = -1; z <= 1; z++) {
            if (!(x == 0 && y == 0 && z == 0) && _activeCubes.Contains($"{cx + x},{cy + y},{cz + z}"))
              count++;
          }
        }
      }

      return count;
    }
  }
}
