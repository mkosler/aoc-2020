using System;
using System.Collections.Generic;
using System.Linq;

namespace cs
{
  public class p1
  {
    public static void Run(string[] args, string input)
    {
      var adapters = new List<int>{ 0 }; // Outlet joltage

      adapters.AddRange(input.Trim().Split('\n').Select(line => Convert.ToInt32(line)));

      adapters.Sort();

      adapters.Add(adapters[adapters.Count - 1] + 3); // Device joltage

      var counts = new[]{ 0, 0, 0 };

      for (int i = 0; i < adapters.Count - 1; i++) {
        var diff = adapters[i + 1] - adapters[i];
        counts[diff - 1]++;
      }

      Console.WriteLine($"1-jolt: {counts[0]}, 3-jolt: {counts[2]}, Product: {counts[0] * counts[2]}");
    }
  }
}
