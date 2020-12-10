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
          if (a != b && a + b == 2020) {
            Console.WriteLine($"{a} * {b} = {a * b}");
            return;
          }
        }
      }
    }
  }
}
