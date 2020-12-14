using System;

namespace cs
{
  public class p1
  {
    public static void Run(string[] args, string input)
    {
      var instructions = InstructionHandler.Parse(input);
      var ship = new Ship(0, 0, 0);

      InstructionHandler.Execute(instructions, ship);

      Console.WriteLine(Math.Abs(ship.X) + Math.Abs(ship.Y));
    }
  }
}
