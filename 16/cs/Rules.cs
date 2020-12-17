using System;
using System.Collections.Generic;
using System.Text.RegularExpressions;
using System.Linq;

namespace cs
{
  public class Rules
  {
    private Dictionary<string, Func<int, bool>> _rules = new Dictionary<string, Func<int, bool>>();
    public int Count { get { return _rules.Count; } }

    public Rules()
    {
    }

    public static Rules Parse(string s)
    {
      var r = new Rules();

      foreach (Match m in Regex.Matches(s, @"([^:]+): (\d+)-(\d+) or (\d+)-(\d+)")) {
        var name = m.Groups[1].Value;
        var b1 = Convert.ToInt32(m.Groups[2].Value);
        var b2 = Convert.ToInt32(m.Groups[3].Value);
        var b3 = Convert.ToInt32(m.Groups[4].Value);
        var b4 = Convert.ToInt32(m.Groups[5].Value);

        r._rules[name] = (int n) => {
          return (b1 <= n && n <= b2) || (b3 <= n && n <= b4);
        };
      }

      return r;
    }

    public bool IsValid(int n)
    {
      foreach (var (name, f) in _rules) {
        if (f(n)) return true;
      }

      return false;
    }

    public HashSet<string> GetValidRulesFor(int n)
    {
      var valids = new HashSet<string>();

      foreach (var (name, f) in _rules) {
        if (f(n)) valids.Add(name);
      }

      return valids;
    }

    public IEnumerable<string> GetAllRuleNames()
    {
      return _rules.Keys.ToList();
    }
  }
}
