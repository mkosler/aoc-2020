using System;

namespace cs
{
  public class p1
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
      var maxSeatId = -1;

      foreach (var line in input.TrimEnd().Split('\n')) {
        var row = BSP(128, line.Substring(0, 7), 'F', 'B');
        var seat = BSP(8, line.Substring(7), 'L', 'R');
        var id = row * 8 + seat;

        if (id > maxSeatId) maxSeatId = id;
      }

      Console.WriteLine($"Highest Seat ID: {maxSeatId}");
    }
  }
}
