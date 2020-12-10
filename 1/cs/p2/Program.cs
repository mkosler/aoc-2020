using System;
using System.Collections.Generic;

namespace p1
{
  class Program
  {
    static void Main(string[] args)
    {
      var expenses = new List<int>();

      string line;
      while ((line = Console.ReadLine()) != null) {
        expenses.Add(Convert.ToInt32(line));
      }

      foreach (var a in expenses) {
        foreach (var b in expenses) {
          foreach (var c in expenses) {
            if (a != b && a != c && b != c && a + b + c == 2020) {
              Console.WriteLine($"{a} * {b} * {c} = {a * b * c}");
              return;
            }
          }
        }
      }
    }
  }
}
