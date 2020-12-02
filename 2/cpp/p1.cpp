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
    std::smatch match = *i;

    int min = std::stoi(match.str(1));
    int max = std::stoi(match.str(2));
    auto letter = match.str(3);
    auto password = match.str(4);

    auto count = std::count(password.begin(), password.end(), letter[0]);

    if (min <= count && count <= max) {
      validPasswords++;
    }
  }

  std::cout << "validPasswords:" << '\t' << validPasswords << std::endl;

  return 0;
}
