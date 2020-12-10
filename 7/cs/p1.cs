using System;
using System.Collections.Generic;
using System.Text.RegularExpressions;

namespace cs
{
  public class p1
  {
    public static bool BagSearch(Dictionary<string, Bag> bags, Bag current, string targetColor)
    {
      if (current.Color == targetColor) return true;
      if (current.Children.Count == 0) return false;

      foreach (var child in current.Children.Keys) {
        if (BagSearch(bags, bags[child], targetColor)) return true;
      }

      return false;
    }

    public static void Run(string[] args, string input)
    {
      var bags = new Dictionary<string, Bag>();

      foreach (var line in input.Split('\n')) {
        var b = new Bag
        {
          Color = Regex.Match(line, @"^\w+ \w+").Value
        };

        foreach (Match match in Regex.Matches(line, @"(\d+) (\w+ \w+) bag[s]?")) {
          b.Children.Add(match.Groups[2].Value, Convert.ToInt32(match.Groups[1].Value));
        }

        bags.Add(b.Color, b);
      }

      var targetColor = "shiny gold";
      var count = 0;

      foreach (var kvp in bags) {
        if (kvp.Key != targetColor && BagSearch(bags, kvp.Value, targetColor)) count++;
      }

      Console.WriteLine($"Total possible outermost bags: {count}");
    }
  }
}
