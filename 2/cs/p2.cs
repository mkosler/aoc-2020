using System;
using System.Collections.Generic;
using System.Text.RegularExpressions;
using System.Linq;

namespace cs
{
  public class p2
  {
    public static void Run(string[] args)
    {
      var validPasswords = 0;

      string line;
      while ((line = Console.ReadLine()) != null) {
        var match = Regex.Match(line, @"(\d+)-(\d+)\s+(\w):\s+(\w+)");

        var pos1 = Convert.ToInt32(match.Groups[1].Value) - 1;
        var pos2 = Convert.ToInt32(match.Groups[2].Value) - 1;
        var letter = Convert.ToChar(match.Groups[3].Value);
        var password = match.Groups[4].Value;

        var count = 0;

        if (password[pos1] == letter) count++;
        if (password[pos2] == letter) count++;

        if (count == 1) validPasswords++;
      }

      Console.WriteLine($"Valid passwords: {validPasswords}");
    }
  }
}
