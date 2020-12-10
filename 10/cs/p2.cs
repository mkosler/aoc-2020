using System;
using System.Collections.Generic;
using System.Linq;

namespace cs
{
  public class p2
  {
    private static int Factorial(int n)
    {
      if (n == 0) return 1;

      var v = n;
      for (var i = 1; i < n; i++) {
        v *= i;
      }

      return v;
    }

    private static int Choose(int n, int r)
    {
      return Factorial(n) / (Factorial(n - r) * Factorial(r));
    }

    public static void Run(string[] args, string input)
    {
      var adapters = new List<int>{ 0 }; // Outlet joltage

      adapters.AddRange(input.Trim().Split('\n').Select(line => Convert.ToInt32(line)));

      adapters.Sort();

      adapters.Add(adapters[adapters.Count - 1] + 3); // Device joltage

      var chains = new List<List<int>>();

      var chain = new List<int>();
      foreach (var j in adapters) {
        if (chain.Count > 0 && j - chain[chain.Count - 1] == 3) {
          chains.Add(chain);
          chain = new List<int>();
        }

        chain.Add(j);
      }

      long arrangements = 1;

      foreach (var c in chains) {
        if (c.Count >= 3) {
          var count = 0;
          var innerLength = c.Count - 2;

          for (var i = 0; i <= innerLength; i++) {
            count += Choose(innerLength, i);
          }

          for (var i = 0; i < c.Count - 1; i++) {
            for (var j = i + 1; j < c.Count; j++) {
              if (c[j] - c[i] > 3) {
                count--;
              }
            }
          }

          arrangements *= count;
        }
      }

      Console.WriteLine($"Total combinations: {arrangements}");
    }
  }
}
