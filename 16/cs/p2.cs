using System;
using System.Collections.Generic;
using System.Linq;

namespace cs
{
  public class p2
  {
    public static void Run(string[] args, string input)
    {
      var sections = input.Split("\n\n").ToList();

      var rules = Rules.Parse(sections[0]);
      var tickets = sections[2]
        .Split('\n')
        .Skip(1)
        .Select(line => line.Split(',').Select(s => Convert.ToInt32(s)))
        .Where(t => t.All(n => rules.IsValid(n)));
      var myTicket = sections[1]
        .Split('\n')
        .Skip(1)
        .Select(line => line.Split(',').Select(s => Convert.ToInt32(s))).ToList()[0].ToList();

      var validRulesForTickets = tickets
        .Select(t => t.Select(n => rules.GetValidRulesFor(n)).ToList());

      var combinedRules = new List<HashSet<string>>();
      var ruleNames = rules.GetAllRuleNames();

      for (var i = 0; i < rules.Count; i++) {
        var combined = new HashSet<string>(ruleNames);

        foreach (var validRules in validRulesForTickets) {
          combined.IntersectWith(validRules[i]);
        }

        combinedRules.Add(combined);
      }

      var count = 0;
      var rulesByPosition = new Dictionary<int, string>();

      while (count < rules.Count) {
        foreach (var (cr, i) in combinedRules.Select((o, i) => (o, i))) {
          if (cr.Count == 1) {
            count++;
            rulesByPosition[i] = cr.ToList()[0];

            foreach (var cr2 in combinedRules) {
              cr2.Remove(rulesByPosition[i]);
            }
          }
        }
      }

      long product = 1;
      foreach (var (i, name) in rulesByPosition) {
        if (name.Contains("departure")) product *= myTicket[i];
      }

      Console.WriteLine(product);
    }
  }
}
