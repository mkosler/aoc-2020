using System;
using System.Collections.Generic;
using System.Linq;

namespace cs
{
  public class p1
  {
    public static void Run(string[] args, string input)
    {
      var sections = input.Split("\n\n");

      var rules = Rules.Parse(sections[0]);
      var invalids = String.Join(',', sections[2].Split('\n').Skip(1)) // convert from several lines of CSV to one long CSV, skipping the header line
        .Split(',')
        .Select(s => Convert.ToInt32(s))
        .Where(n => !rules.IsValid(n));

      Console.WriteLine(invalids.Sum());
    }
  }
}
