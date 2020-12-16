using System;
using System.Collections.Generic;

namespace cs
{
  public class MemoryGame
  {
    private Dictionary<int, List<int>> _numbers = new Dictionary<int, List<int>>();
    public int? LastNumber { get; private set; } = null;
    public int Turn { get; private set; } = 0;

    public MemoryGame()
    {
    }

    public void Add(int n)
    {
      LastNumber = n;
      if (!Exists(n)) _numbers[n] = new List<int>();
      _numbers[n].Add(++Turn);
    }

    public bool Exists(int n)
    {
      return _numbers.ContainsKey(n);
    }

    public int SpokenCount(int n)
    {
      if (!Exists(n)) return 0;
      return _numbers[n].Count;
    }

    public (int, int) GetLastTwoTurns(int n)
    {
      var nTurns = _numbers[n];
      return (nTurns[nTurns.Count - 1], nTurns[nTurns.Count - 2]);
    }
  }
}
