using System;
using System.Collections.Generic;

struct Point
{
  public int R, C;
}

namespace cs
{
  public class p1
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

      var pos = new Point{ R = 0, C = 0 };
      var velocity = new Point{ R = 1, C = 3 };
      var treeCount = 0;

      while (pos.R < height) {
        pos.C = (pos.C + velocity.C) % width;
        pos.R += velocity.R;

        if (pos.R >= height) break;

        if (map[pos.R][pos.C]) treeCount++;
      }

      Console.WriteLine($"Tree count: {treeCount}");
    }
  }
}
