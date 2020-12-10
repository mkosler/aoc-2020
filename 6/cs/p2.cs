using System;
using System.Collections.Generic;
using System.Linq;

namespace cs
{
  public class p2
  {
    public static void Run(string[] args, string input)
    {
      var sum = 0;

      foreach (var group in input.Substring(0, input.Length - 1).Split("\n\n")) {
        var answers = new Dictionary<char, int>();
        var pplCount = group.Count(c => c == '\n') + 1;

        foreach (var c in group) {
          if (!answers.ContainsKey(c)) answers[c] = 0;

          answers[c]++;
        }

        foreach (var a in answers.Values) {
          if (a == pplCount) sum++;
        }
      }

      Console.WriteLine($"Sum of counts: {sum}");
    }
  }
}
