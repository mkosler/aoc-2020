#include <iostream>
#include <string>
#include <sstream>
#include <vector>
#include <map>
#include <algorithm>

std::vector<std::string> split(const std::string& s, const std::string& delimiter)
{
  std::vector<std::string> splits;
  int pos = 0;

  while (true) {
    auto next = s.find(delimiter, pos);
    auto subs = s.substr(pos, next - pos);

    splits.push_back(subs);

    if (next == std::string::npos) break;

    pos = next + delimiter.size();
  }

  return splits;
}

int main(int argc, char* argv[])
{
  std::stringstream ss;
  ss << std::cin.rdbuf();
  auto file = ss.str();
  file = file.substr(0, file.size() - 1);

  auto groups = split(file, "\n\n");
  int sum = 0;

  for (auto group : groups) {
    std::map<char, int> answers;

    auto pplCount = std::count(group.begin(), group.end(), '\n') + 1;

    for (char c : group) {
      if (c != '\n' && answers.find(c) == answers.end()) {
        answers[c] = 0;
      }

      answers[c]++;
    }

    for (auto a : answers) {
      if (a.second == pplCount) sum++;
    }
  }

  std::cout << "Sum of counts: " << sum << std::endl;

  return 0;
}
