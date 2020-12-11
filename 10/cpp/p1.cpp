#include <iostream>
#include <string>
#include <vector>
#include <algorithm>

int main(int argc, char* argv[])
{
  std::vector<int> adapters{ 0 };

  for (std::string line; std::getline(std::cin, line); ) {
    adapters.push_back(std::stoi(line));
  }

  std::sort(adapters.begin(), adapters.end());

  adapters.push_back(*(adapters.end() - 1) + 3);

  int counts[] = { 0, 0, 0 };

  for (auto i = 0; i < adapters.size() - 1; i++) {
    auto diff = adapters[i + 1] - adapters[i];
    counts[diff - 1]++;
  }

  std::cout << "1J: " << counts[0] << ", 3J: " << counts[2] << ", product: " << counts[0] * counts[2] << std::endl;

  return 0;
}
