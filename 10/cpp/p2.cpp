#include <iostream>
#include <string>
#include <vector>
#include <algorithm>

int factorial(int n)
{
  if (n == 0) return 1;

  auto v = n;
  for (auto i = 1; i < n; i++) {
    v *= i;
  }

  return v;
}

int choose(int n, int r)
{
  return factorial(n) / (factorial(n - r) * factorial(r));
}

int main(int argc, char* argv[])
{
  std::vector<int> adapters{ 0 };

  for (std::string line; std::getline(std::cin, line); ) {
    adapters.push_back(std::stoi(line));
  }

  std::sort(adapters.begin(), adapters.end());

  adapters.push_back(*(adapters.end() - 1) + 3);

  std::vector<std::vector<int>> chains;

  std::vector<int> chain;

  for (auto j : adapters) {
    if (chain.size() > 0 && j - chain[chain.size() - 1] == 3) {
      chains.push_back(chain);
      chain = std::vector<int>();
    }

    chain.push_back(j);
  }

  long arrangements = 1;

  for (auto& c : chains) {
    if (c.size() >= 3) {
      auto count = 0;
      auto innerLength = c.size() - 2;

      for (auto i = 0; i <= innerLength; i++) {
        count += choose(innerLength, i);
      }

      for (auto i = 0; i < c.size() - 1; i++) {
        for (auto j = i + 1; j < c.size(); j++) {
          if (c[j] - c[i] > 3) count--;
        }
      }

      arrangements *= count;
    }
  }

  std::cout << "Total combinations: " << arrangements << std::endl;

  return 0;
}
