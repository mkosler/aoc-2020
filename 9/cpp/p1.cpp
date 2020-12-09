#include <iostream>
#include <deque>
#include <string>

class XmasQueue
{
  private:
    std::deque<int> _data;
    int _capacity;

  public:
    XmasQueue(int capacity) : _capacity(capacity) {}

    void Enqueue(int v)
    {
      _data.push_back(v);

      if (_capacity < _data.size()) _data.pop_front();
    }

    bool Test(int v)
    {
      for (const auto a : _data) {
        for (const auto b : _data) {
          if (a != b && a + b == v) return true;
        }
      }

      return false;
    }

    int Count()
    {
      return _data.size();
    }
};

int main(int argc, char* argv[])
{
  if (argc < 2) {
    std::cerr << "missing PREAMBLE_SIZE" << std::endl;
    return 1;
  }

  const int PREAMBLE_SIZE = std::stoi(argv[1]);

  XmasQueue xq(PREAMBLE_SIZE);

  for (std::string line; std::getline(std::cin, line); ) {
    auto v = std::stoi(line);

    if (xq.Count() == PREAMBLE_SIZE && !xq.Test(v)) {
      std::cout << "First failure: " << v << std::endl;
      return 0;
    }

    xq.Enqueue(v);
  }

  return 0;
}
