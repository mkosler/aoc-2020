using System;
using System.Collections.Generic;

namespace cs
{
  public class p1
  {
    public static void Run(string[] args, string input)
    {
      var sum = 0;

      foreach (var group in input.Split("\n\n")) {
        var answers = new Dictionary<char, bool>();

        foreach (var c in group) {
          if (c != '\n' && !answers.ContainsKey(c)) {
            answers[c] = true;
            sum++;
          }
        }
      }

      Console.WriteLine($"Sum of counts: {sum}");
    }
  }
}
