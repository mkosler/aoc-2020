using System;

namespace cs
{
  public class Ship
  {
    public int X { get; private set; }
    public int Y { get; private set; }
    public int Rotation { get; private set; }

    public Ship(int x, int y, int rotation)
    {
      X = x;
      Y = y;
      Rotation = rotation;
    }

    public void Move(int dx, int dy)
    {
      X += dx; Y += dy;
    }

    public void Turn(int angle)
    {
      Rotation = (Rotation + angle) % 360;
    }
  }
}
