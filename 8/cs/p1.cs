using System;
using System.Collections.Generic;

namespace cs
{
  public class p1
  {
    public static int Execute(List<Instruction> program, int lineNumber, int accumulator)
    {
      var line = program[lineNumber];

      if (line.Called > 0) return accumulator;
      line.Called++;

      switch (line.Instr) {
        case "nop":
          return Execute(program, lineNumber + 1, accumulator);
        case "jmp":
          return Execute(program, lineNumber + line.Parameter, accumulator);
        case "acc":
          return Execute(program, lineNumber + 1, accumulator + line.Parameter);
        default:
          throw new Exception("How'd we get here?");
      }
    }

    public static void Run(string[] args, string input)
    {
      var program = new List<Instruction>();

      foreach (var line in input.TrimEnd().Split('\n')) {

        program.Add(new Instruction
          {
            Line = line,
            Instr = line.Substring(0, 3),
            Parameter = Convert.ToInt32(line.Substring(4)),
            Called = 0
          });
      }

      Console.WriteLine($"Accumulator on first repeat: {Execute(program, 0, 0)}");
    }
  }
}
