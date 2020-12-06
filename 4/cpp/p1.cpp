#include <iostream>
#include <string>
#include <sstream>
#include <vector>

const std::string REQUIRED_FIELDS = "byriyreyrhgthcleclpid";

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

bool validate(std::string pp)
{
  for (int i = 0; i < REQUIRED_FIELDS.size(); i += 3) {
    auto field = REQUIRED_FIELDS.substr(i, 3);

    if (pp.find(field) == std::string::npos) return false;
  }

  return true;
}

int main(int argc, char* argv[])
{
  int validCount = 0;

  std::stringstream ss;
  ss << std::cin.rdbuf();
  auto file = ss.str();

  auto passports = split(file, "\n\n");

  for (int i = 0; i < passports.size(); i++) {
    if (validate(passports[i])) validCount++;
  }

  std::cout << "valid passports: " << validCount << std::endl;

  return 0;
}
