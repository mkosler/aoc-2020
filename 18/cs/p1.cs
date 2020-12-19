using System;
using System.Text.RegularExpressions;

namespace cs
{
  public class p1
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

    private static long Evaluate(string statement)
    {
      var addition = new Regex(@"(\d+)\s+\+\s+(\d+)");
      var multiplication = new Regex(@"(\d+)\s+\*\s+(\d+)");

      while (statement.Contains('(')) {
        var start = statement.IndexOf('(');
        var innerStatement = FindBalancedClosedParenthesis(statement.Substring(start + 1));
        statement = statement.Replace($"({innerStatement})", Evaluate(innerStatement).ToString());
      }

      long res = 0;
      string op = "";
      var firstNumber = true;

      foreach (Match m in Regex.Matches(statement, @"[0-9+*]+")) {
        var c = m.Value;

        int n;
        if (int.TryParse(c, out n)) {
          if (firstNumber) {
            firstNumber = false;
            res = n;
          } else if (op == "+") {
            res += n;
          } else if (op == "*") {
            res *= n;
          }
        } else if (c == "+" || c == "*") {
          op = c;
        }
      }

      return res;
    }

    public static void Run(string[] args, string input)
    {
      long sum = 0;

      foreach (var line in input.Split('\n')) {
        var n = Evaluate(line);
        sum += n;
        Console.WriteLine($"{line} = {n}");
      }
    }
  }
}
