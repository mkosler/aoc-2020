using System;
using System.Collections.Generic;
using System.Text.RegularExpressions;
using System.Linq;

namespace cs
{
  public class p2
  {
    /* private static string[] REQUIRED_FIELDS = new[] { */
    /*   "byr", */
    /*   "iyr", */
    /*   "eyr", */
    /*   "hgt", */
    /*   "hcl", */
    /*   "ecl", */
    /*   "pid" */
    /* }; */

    private static Dictionary<string, Func<string, bool>> _validationRules = new Dictionary<string, Func<string, bool>>
    {
      {
        "byr",
        (string o) =>
        {
          int n;
          if (!int.TryParse(o, out n)) return false;
          return 1920 <= n && n <= 2002;
        }
      },
      {
        "iyr",
        (string o) =>
        {
          int n;
          if (!int.TryParse(o, out n)) return false;
          return 2010 <= n && n <= 2020;
        }
      },
      {
        "eyr",
        (string o) =>
        {
          int n;
          if (!int.TryParse(o, out n)) return false;
          return 2020 <= n && n <= 2030;
        }
      },
      {
        "hgt",
        (string o) =>
        {
          var match = Regex.Match(o, @"(\d+)(\w\w)");
          var i = Convert.ToInt32(match.Groups[1].Value);
          var m = match.Groups[2].Value;

          if (m == "cm") return 150 <= i && i <= 193;
          if (m == "in") return 59 <= i && i <= 76;
          return false;
        }
      },
      {
        "hcl",
        (string o) =>
        {
          return o.Length == 7 && Regex.IsMatch(o, @"#[a-fA-F0-9]+");
        }
      },
      {
        "ecl",
        (string o) =>
        {
          var colors = new[] { "amb", "blu", "brn", "gry", "grn", "hzl", "oth" };

          foreach (var c in colors) {
            if (o == c) return true;
          }

          return false;
        }
      },
      {
        "pid",
        (string o) =>
        {
          return o.Length == 9 && int.TryParse(o, out int output);
        }
      }
    };

    private static bool Validate(string passport)
    {
      var t = new Dictionary<string, string>();

      foreach (Match match in Regex.Matches(passport, @"(\w+):([#\w]+)")) {
        t.Add(match.Groups[1].Value, match.Groups[2].Value);
        /* t.Add(k, v); */
      }

      foreach (var kvp in _validationRules) {
        if (!t.ContainsKey(kvp.Key) || !kvp.Value(t[kvp.Key])) return false;
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
