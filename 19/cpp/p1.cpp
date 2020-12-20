#include <iostream>
#include <string>
#include <sstream>
#include <map>

int main(int argc, char* argv[])
{
  std::stringstream ss;
  ss << std::cin.rdbuf();
  auto file = ss.str();

  auto pos = file.find("\n\n");

  ss.str("");
  ss << file.substr(pos);

  std::map<int, std::string> rules;
  for (std::string line; std::getline(ss, line); ) {
  }

  return 0;
}
