#include <iostream>
#include <string>
#include <regex>
#include <map>
#include <iterator>

struct Bag
{
  std::string Color;
  std::map<std::string, int> Children;
};

bool bagSearch(std::map<std::string, Bag>& bags, const Bag& current, const std::string& targetColor)
{
  if (current.Color == targetColor) return true;
  if (current.Children.size() == 0) return false;

  for (const auto& cb : current.Children) {
    if (bagSearch(bags, bags[cb.first], targetColor)) return true;
  }

  return false;
}

int main(int argc, char* argv[])
{
  const std::string targetColor = "shiny gold";
  int count = 0;
  std::map<std::string, Bag> bags;

  std::regex bagMatch("^\\w+ \\w+");
  std::regex childMatch("(\\d+) (\\w+ \\w+) bag[s]?");
  std::smatch result;

  for (std::string rule; std::getline(std::cin, rule); ) {
    Bag b;

    std::regex_search(rule, result, bagMatch);
    b.Color = result.str(0);

    auto childBegin = std::sregex_iterator(rule.begin(), rule.end(), childMatch);
    auto childEnd = std::sregex_iterator();

    for (auto i = childBegin; i != childEnd; i++) {
      result = *i;

      auto count = std::stoi(result.str(1));
      auto color = result.str(2);

      b.Children[color] = count;
    }

    bags[b.Color] = b;
  }

  for (const auto& b : bags) {
    if (b.first != targetColor && bagSearch(bags, b.second, targetColor)) {
      count++;
    }
  }

  std::cout << "Total possible outermost bags: " << count << std::endl;

  return 0;
}
