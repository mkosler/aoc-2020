using System;
using System.Collections.Generic;

namespace cs
{
  public class Bag
  {
    public string Color { get; set; }
    public Dictionary<string, int> Children = new Dictionary<string, int>();
  }
}
