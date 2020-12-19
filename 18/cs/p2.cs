using System;
using System.Text.RegularExpressions;

namespace cs
{
  public class p2
  {
    private static string FindBalancedClosedParenthesis(string statement)
    {
      int count = 1; // Assume our statement already found the opening parenthesis

      for (int i = 0; i < statement.Length; i++) {
        var c = statement[i];

        if (c == '(') count++;
        else if (c == ')') {
          count--;

          if (count == 0) {
            return statement.Substring(0, i);
          }
        }
      }

      throw new Exception("Cannot find balanced close parenthesis");
    }

    private static int Evaluate(string statement)
    {
      while (statement.Contains('(')) {
        var start = statement.IndexOf('(');
        var innerStatement = FindBalancedClosedParenthesis(statement.Substring(start + 1));
        statement = statement.Replace($"({innerStatement})", Evaluate(innerStatement).ToString());
      }

      var addition = new Regex(@"(\d+)\s+\+\s+(\d+)");
      while (addition.IsMatch(statement)) {
        statement = addition.Replace(statement, new MatchEvaluator((match) => {
          return $"{Convert.ToInt32(match.Groups[1].Value) + Convert.ToInt32(match.Groups[2].Value)}";
        }));
      }

      var multiplication = new Regex(@"(\d+)\s+\*\s+(\d+)");
      while (multiplication.IsMatch(statement)) {
        statement = multiplication.Replace(statement, new MatchEvaluator((match) => {
          return $"{Convert.ToInt32(match.Groups[1].Value) * Convert.ToInt32(match.Groups[2].Value)}";
        }));
      }

      return Convert.ToInt32(statement);
    }

    public static void Run(string[] args, string input)
    {
      foreach (var line in input.Split('\n')) {
        Console.WriteLine($"{line} = {Evaluate(line)}");
      }
    }
  }
}
