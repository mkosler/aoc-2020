#include <iostream>
#include <string>
#include <vector>
#include <sstream>
#include "rules.h"

std::vector<std::string> split(const std::string& s, const std::string& delim)
{
  std::vector<std::string> splits;
  int pos = 0;

  while (true) {
    auto next = s.find(delim, pos);
    auto subs = s.substr(pos, next - pos);

    splits.push_back(subs);
    if (next == std::string::npos) break;

    pos = next + delim.size();
  }

  return splits;
}

int main(int argc, char* argv[])
{
  std::stringstream ss;
  ss << std::cin.rdbuf();
  auto file = ss.str();
  file = file.substr(0, file.size() - 1); // remove trailing newline

  auto sections = split(file, "\n\n");

  Rules r;
  r.Parse(sections[0]);

  std::stringstream tss;
  tss << sections[2];

  auto firstLine = true;
  for (std::string line; std::getline(tss, line); ) {
    if (firstLine) firstLine = false;
    else {

    }
  }

  /* int n, sum = 0; */
  /* while (ss >> n) { */
  /*   std::cout << n << ": " << r.IsValid(n) << std::endl; */
  /*   if (!r.IsValid(n)) sum += n; */
  /* } */

  /* std::cout << sum << std::endl; */

  return 0;
}
