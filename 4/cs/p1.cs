using System;
using System.Collections.Generic;
/* using System.Text.RegularExpressions; */

namespace cs
{
  public class p1
  {
    private static string[] REQUIRED_FIELDS = new[] {
      "byr",
      "iyr",
      "eyr",
      "hgt",
      "hcl",
      "ecl",
      "pid"
    };

    private static bool Validate(string passport)
    {
      foreach (var field in REQUIRED_FIELDS) {
        if (!passport.Contains(field + ':')) return false;
      }

      return true;
    }

    public static void Run(string[] args, string input)
    {
      var validCount = 0;

      foreach (var passport in input.Split("\n\n")) {
        if (Validate(passport)) validCount++;
      }

      Console.WriteLine($"Total valid passports: {validCount}");
    }
  }
}
