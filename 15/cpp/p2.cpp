#include <iostream>
#include <string>
#include <map>
#include <vector>

class MemoryGame
{
  private:
    std::map<int, std::vector<int>> _numbers;
    int _lastNumber = -1;
    int _turn = 0;

  public:
    MemoryGame() {}

    void Add(int n)
    {
      _lastNumber = n;
      if (!Exists(n)) _numbers[n] = std::vector<int>();
      _numbers[n].push_back(++_turn);
    }

    bool Exists(int n)
    {
      return _numbers.find(n) != _numbers.end();
    }

    int SpokenCount(int n)
    {
      if (!Exists(n)) return 0;
      return _numbers[n].size();
    }

    void GetLastTwoTurns(int n, int& t1, int& t2)
    {
      auto nTurns = _numbers[n];
      t1 = nTurns[nTurns.size() - 1];
      t2 = nTurns[nTurns.size() - 2];
    }

    int GetTurn()
    {
      return _turn;
    }

    int GetLastNumber()
    {
      return _lastNumber;
    }
};

int main(int argc, char* argv[])
{
  MemoryGame game;
  int n;
  char ch;

  while (std::cin >> n) {
    game.Add(n);

    std::cin >> ch;
  }

  while (game.GetTurn() < 30000000) {
    if (game.SpokenCount(game.GetLastNumber()) < 2) game.Add(0);
    else {
      int t1, t2;
      game.GetLastTwoTurns(game.GetLastNumber(), t1, t2);
      game.Add(t1 - t2);
    }
  }

  std::cout << game.GetLastNumber() << std::endl;

  return 0;
}
