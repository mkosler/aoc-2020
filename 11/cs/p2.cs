using System;
using System.Text;
using System.Collections.Generic;
using System.Linq;

namespace cs
{
  public class p2
  {
    private static bool TestNearestNeighbor(List<List<SeatState>> grid, int cr, int cc, int dr, int dc)
    {
      if (cr < 0 || cc < 0 || cr > grid.Count - 1 || cc > grid[cr].Count - 1) return false;
      if (grid[cr][cc] != SeatState.FLOOR) return grid[cr][cc] == SeatState.OCCUPIED;
      return TestNearestNeighbor(grid, cr + dr, cc + dc, dr, dc);
    }

    private static int CountOccupiedNeighbors(List<List<SeatState>> grid, int r, int c)
    {
      var count = 0;
      for (var dr = -1; dr <= 1; dr++) {
        for (var dc = -1; dc <= 1; dc++) {
          if (!(dr == 0 && dc == 0) && TestNearestNeighbor(grid, r + dr, c + dc, dr, dc)) count++;
        }
      }

      return count;
    }

    private static int ApplyRules(List<List<SeatState>> grid)
    {
      var current = grid.Select(o => o.ToList()).ToList();
      var change = 0;

      for (var r = 0; r < current.Count; r++) {
        for (var c = 0; c < current[r].Count; c++) {
          if (current[r][c] != SeatState.FLOOR) {
            var count = CountOccupiedNeighbors(current, r, c);

            if (current[r][c] == SeatState.EMPTY && count == 0) {
              change++;
              grid[r][c] = SeatState.OCCUPIED;
            }

            if (current[r][c] == SeatState.OCCUPIED && count >= 5) {
              change++;
              grid[r][c] = SeatState.EMPTY;
            }
          }
        }
      }

      return change;
    }

    private static string GridToString(List<List<SeatState>> grid)
    {
      var sb = new StringBuilder();

      for (var r = 0; r < grid.Count; r++) {
        for (var c = 0; c < grid[r].Count; c++) {
          switch (grid[r][c]) {
            case SeatState.FLOOR:
              sb.Append('.');
              break;
            case SeatState.EMPTY:
              sb.Append('L');
              break;
            case SeatState.OCCUPIED:
              sb.Append('#');
              break;
            default:
              throw new Exception("Que?");
          }
        }
        sb.Append('\n');
      }

      return sb.ToString();
    }

    public static void Run(string[] args, string input)
    {
      var grid = new List<List<SeatState>>();

      foreach (var line in input.Split('\n')) {
        var row = new List<SeatState>();

        foreach (var c in line) {
          switch (c) {
            case '#':
              row.Add(SeatState.OCCUPIED);
              break;
            case 'L':
              row.Add(SeatState.EMPTY);
              break;
            case '.':
              row.Add(SeatState.FLOOR);
              break;
            default:
              throw new Exception("Huh?");
          }
        }

        grid.Add(row);
      }

      while (ApplyRules(grid) > 0) {}

      Console.WriteLine($"Occupied: {grid.SelectMany(o => o).Count(o => o == SeatState.OCCUPIED)}");
    }
  }
}
