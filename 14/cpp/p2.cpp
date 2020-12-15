#include <iostream>
#include <string>
#include <map>
#include <regex>
#include <vector>

typedef std::map<int, char> Mask;

Mask createMask(std::string line)
{
  std::smatch match;
  std::regex_match(line, match, std::regex(R"(mask = ([X01]+))"));

  Mask mask;
  auto s = match.str(1);

  for (int i = 0; i < s.size(); i++) {
    mask[s.size() - 1 - i] = s[i];
  }

  return mask;
}

/* int applyMask(int n, Mask mask) */
/* { */
/*   for (const auto& kvp : mask) { */
/*     auto bit = 1 << kvp.first; */

/*     if (kvp.second == '0' && (n & bit) > 0) n -= bit; */
/*     else if (kvp.second == '1' && (n & bit) == 0) n += bit; */
/*   } */

/*   return n; */
/* } */

std::vector<long> getAllAddresses(int n, Mask mask)
{
  std::vector<long> addresses;
  std::vector<int> xs;

  for (const auto& kvp : mask) {
    auto bit = 1 << kvp.first;

    if (kvp.second == '1') {
      n |= bit;
    } else if (kvp.second == 'X') {
      xs.push_back(kvp.first);

      if ((n & bit) > 0) {
        n -= bit;
      }
    }
  }

  addresses.push_back(n);

  for (const auto& v : xs) {
    for (int i = addresses.size() - 1; i >= 0; i--) {
      addresses.push_back(addresses[i] + (1 << v));
    }
  }

  return addresses;
}

int main(int argc, char* argv[])
{
  Mask mask;
  std::map<int, int> memory;
  std::smatch match;

  for (std::string line; std::getline(std::cin, line); ) {
    if (line.find("mask") != std::string::npos) {
      mask = createMask(line);
    } else {
      std::regex_match(line, match, std::regex(R"(mem\[(\d+)\] = (\d+))"));

      auto addresses = getAllAddresses(std::stoi(match.str(1)), mask);
      for (const auto& a : addresses) {
        memory[a] = std::stoi(match.str(2));
      }
    }
  }

  long sum = 0;
  for (const auto& kvp : memory) {
    sum += kvp.second;
  }

  std::cout << sum << std::endl;

  return 0;
}
