using System;
using System.Text;
using System.Collections.Generic;
using System.Linq;

namespace cs
{
  public class p1
  {
    private static int CountOccupiedNeighbors(List<List<SeatState>> grid, int r, int c)
    {
      var bounds = new {
        Left = c - 1 < 0 ? 0 : c - 1,
        Right = c + 1 > grid[r].Count - 1 ? grid[r].Count - 1 : c + 1,
        Top = r - 1 < 0 ? 0 : r - 1,
        Bottom = r + 1 > grid.Count - 1 ? grid.Count - 1 : r + 1
      };

      var count = 0;
      for (var nr = bounds.Top; nr <= bounds.Bottom; nr++) {
        for (var nc = bounds.Left; nc <= bounds.Right; nc++) {
          if (!(nr == r && nc == c) && grid[nr][nc] == SeatState.OCCUPIED) count++;
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

            if (current[r][c] == SeatState.OCCUPIED && count >= 4) {
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
