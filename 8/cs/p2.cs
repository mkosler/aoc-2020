using System;
using System.Collections.Generic;
using System.Linq;

namespace cs
{
  public class p2
  {
    public static bool Execute(List<Instruction> program, int lineNumber, int accumulator,
        ref List<Instruction> problems)
    {
      if (lineNumber == program.Count) return true;

      var line = program[lineNumber];

      if (line.Called > 0) return false;

      line.Called++;

      if (line.Instr == "nop") {
        if (problems != null) problems.Add(line);
        return Execute(program, lineNumber + 1, accumulator, ref problems);
      } else if (line.Instr == "jmp") {
        if (problems != null) problems.Add(line);
        return Execute(program, lineNumber + line.Parameter, accumulator, ref problems);
      } else {
        return Execute(program, lineNumber + 1, accumulator + line.Parameter, ref problems);
      }
    }

    public static void Run(string[] args, string input)
    {
      var program = new List<Instruction>();

      foreach (var line in input.TrimEnd().Split('\n')) {

        program.Add(new Instruction
          {
            LineNumber = program.Count,
            Line = line,
            Instr = line.Substring(0, 3),
            Parameter = Convert.ToInt32(line.Substring(4)),
            Called = 0
          });
      }

      var acc = 0;
      var problems = new List<Instruction>();
      Execute(program, 0, acc, ref problems);

      foreach (var p in program) p.Called = 0;

      foreach (var p in problems) {
        var newProgram = new List<Instruction>(program.Count);
        program.ForEach((o) => newProgram.Add(new Instruction(o)));
        acc = 0;

        if (p.Instr == "jmp") newProgram[p.LineNumber].Instr = "nop";
        else newProgram[p.LineNumber].Instr = "jmp";

        List<Instruction> workaround = null;
        if (Execute(newProgram, 0, acc, ref workaround)) break;
      }

      Console.WriteLine($"Accumulator: {acc}");
    }
  }
}
