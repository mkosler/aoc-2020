using System;
using System.Collections.Generic;
using System.Text.RegularExpressions;

namespace cs
{
  public class p2
  {
    public static int TotalBagCount(Dictionary<string, Bag> bags, Bag current)
    {
      var sum = 0;

      foreach (var kvp in current.Children) {
        sum += kvp.Value + (kvp.Value * TotalBagCount(bags, bags[kvp.Key]));
      }

      return sum;
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
      Console.WriteLine($"Total bags within: {TotalBagCount(bags, bags[targetColor])}");
    }
  }
}
