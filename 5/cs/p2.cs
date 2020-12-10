using System;
using System.Collections.Generic;

namespace cs
{
  public class p2
  {
    private static int BSP(int max, string passport, char lowKey, char highKey)
    {
      double mid = max / 2.0;
      double diff = mid / 2.0;

      foreach (var c in passport) {
        if (c == lowKey) mid -= diff;
        else if (c == highKey) mid += diff;

        diff /= 2;
      }

      return (int)mid;
    }

    public static void Run(string[] args, string input)
    {
      var seats = new Dictionary<int, bool>();

      foreach (var line in input.TrimEnd().Split('\n')) {
        var row = BSP(128, line.Substring(0, 7), 'F', 'B');
        var seat = BSP(8, line.Substring(7), 'L', 'R');
        var id = row * 8 + seat;

        seats[id] = true;
      }

      foreach (var id in seats.Keys) {
        if (!seats.ContainsKey(id + 1) && seats.ContainsKey(id + 2)) {
          Console.WriteLine($"Our seat is {id + 1}");
          return;
        }
      }
    }
  }
}
