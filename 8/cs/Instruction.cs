using System;

namespace cs
{
  public class Instruction
  {
    public string Line { get; set; }
    public string Instr { get; set; }
    public int Parameter { get; set; }
    public int Called { get; set; }
    public int LineNumber { get; set; }

    public Instruction() { }

    public Instruction(Instruction orig)
    {
      Line = orig.Line;
      Instr = orig.Instr;
      Parameter = orig.Parameter;
      Called = orig.Called;
      LineNumber = orig.LineNumber;
    }
  }
}
