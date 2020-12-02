#include <iostream>
#include <string>
#include <vector>

int main(int argc, char* argv[])
{
  std::vector<int> expenses;

  for (auto n = 0; std::cin >> n; ) {
    expenses.push_back(n);
  }

  for (auto a : expenses) {
    for (auto b : expenses) {
      if (a != b && a + b == 2020) {
        std::cout << a << " " << b << " " << a * b << std::endl;
        return 0;
      }
    }
  }

  return 0;
}
