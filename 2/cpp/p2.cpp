#include <iostream>
#include <string>
#include <sstream>
#include <regex>
#include <iterator>
#include <algorithm>

int main(int argc, char* argv[])
{
  int validPasswords = 0;

  std::stringstream ss;
  ss << std::cin.rdbuf();
  auto file = ss.str();

  std::regex passwordValidator("(\\d+)-(\\d+)\\s(\\w):\\s+(\\w+)");
  auto regexBegin = std::sregex_iterator(file.begin(), file.end(), passwordValidator);
  auto regexEnd = std::sregex_iterator();

  for (auto i = regexBegin; i != regexEnd; i++) {
    int count = 0;

    std::smatch match = *i;

    int p1 = std::stoi(match.str(1));
    int p2 = std::stoi(match.str(2));
    auto letter = match.str(3);
    auto password = match.str(4);

    if (password[p1 - 1] == letter[0]) count++;
    if (password[p2 - 1] == letter[0]) count++;

    if (count == 1) validPasswords++;
  }

  std::cout << "validPasswords:" << '\t' << validPasswords << std::endl;

  return 0;
}
