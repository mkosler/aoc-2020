using System;
using System.Collections.Generic;
using System.Text.RegularExpressions;
using System.Linq;

namespace cs
{
  public class p1
  {
    public static void Run(string[] args)
    {
      var validPasswords = 0;

      string line;
      while ((line = Console.ReadLine()) != null) {
        var match = Regex.Match(line, @"(\d+)-(\d+)\s+(\w):\s+(\w+)");

        var min = Convert.ToInt32(match.Groups[1].Value);
        var max = Convert.ToInt32(match.Groups[2].Value);
        var letter = Convert.ToChar(match.Groups[3].Value);
        var password = match.Groups[4].Value;

        var count = password.Count(c => c == letter);

        if (min <= count && count <= max) validPasswords++;
      }

      Console.WriteLine($"Valid passwords: {validPasswords}");
    }
  }
}
