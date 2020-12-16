using System;
using System.Linq;

namespace cs
{
  public class p1
  {
    public static void Run(string[] args, string input)
    {
      var game = new MemoryGame();

      foreach (var n in input.Split(',').Select(o => Convert.ToInt32(o))) {
        game.Add(n);
      }

      while (game.Turn < 2020) {
        if (game.SpokenCount((int)game.LastNumber) < 2) {
          game.Add(0);
        } else {
          var (t1, t2) = game.GetLastTwoTurns((int)game.LastNumber);
          game.Add(t1 - t2);
        }
      }

      Console.WriteLine(game.LastNumber);
    }
  }
}
