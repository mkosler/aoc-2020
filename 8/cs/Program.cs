using System;

namespace cs
{
  class Program
  {
    static void Main(string[] args)
    {
      var file = Console.In.ReadToEnd();
      
      Console.WriteLine("Part 1");
      p1.Run(args, file);
      Console.WriteLine("Part 2");
      p2.Run(args, file);
    }
  }
}
