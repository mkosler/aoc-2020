using System;
using System.Collections.Generic;

namespace cs
{
  public class p2
  {
    public static void Run(string[] args)
    {
      var map = new List<List<bool>>();

      string line;
      while ((line = Console.ReadLine()) != null) {
        var row = new List<bool>();

        foreach (var c in line) {
          row.Add(c == '#');
        }

        map.Add(row);
      }

      var width = map[0].Count;
      var height = map.Count;

      var velocities = new List<Point>
      {
        new Point{ R = 1, C = 1 },
        new Point{ R = 1, C = 3 },
        new Point{ R = 1, C = 5 },
        new Point{ R = 1, C = 7 },
        new Point{ R = 2, C = 1 }
      };

      long answer = 1;

      foreach (var velocity in velocities) {
        var pos = new Point{ R = 0, C = 0 };
        var treeCount = 0;

        while (pos.R < height) {
          pos.C = (pos.C + velocity.C) % width;
          pos.R += velocity.R;

          if (pos.R >= height) break;

          if (map[pos.R][pos.C]) treeCount++;
        }

        answer *= treeCount;
      }

      Console.WriteLine($"Answer: {answer}");
    }
  }
}
