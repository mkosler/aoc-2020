using System;
using System.Collections.Generic;
using System.Linq;

namespace cs
{
  public class Instruction
  {
    public char Action { get; set; }
    public int Magnitude { get; set; }
  }

  public class InstructionHandler
  {
    public static IEnumerable<Instruction> Parse(string text)
    {
      return text.Split('\n').Select(l => new Instruction
        {
          Action = l[0],
          Magnitude = Convert.ToInt32(l.Substring(1))
        });
    }

    public static void Execute(IEnumerable<Instruction> instructions, Ship ship)
    {
      foreach (var i in instructions) {
        switch (i.Action) {
          case 'N':
            ship.Move(0, i.Magnitude);
            break;
          case 'S':
            ship.Move(0, -i.Magnitude);
            break;
          case 'E':
            ship.Move(i.Magnitude, 0);
            break;
          case 'W':
            ship.Move(-i.Magnitude, 0);
            break;
          case 'L':
            ship.Turn(i.Magnitude);
            break;
          case 'R':
            ship.Turn(-i.Magnitude);
            break;
          case 'F':
            var rad = ship.Rotation * (Math.PI / 180.0);
            ship.Move((int)(i.Magnitude * Math.Cos(rad)), (int)(i.Magnitude * Math.Sin(rad)));
            break;
          default:
            throw new Exception("Que?");
        }
      }
    }
  }
}
