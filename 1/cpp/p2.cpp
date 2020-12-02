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
      for (auto c : expenses) {
        if (a != b && a != c && b != c && a + b + c == 2020) {
          std::cout << a << " " << b << " " << c << " " << a * b * c << std::endl;
          return 0;
        }
      }
    }
  }

  return 0;
}
