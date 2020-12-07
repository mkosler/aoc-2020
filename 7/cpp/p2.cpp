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

int totalBagCount(std::map<std::string, Bag>& bags, Bag& current)
{
  auto sum = 0;

  if (current.Children.size() == 0) return sum;

  for (const auto& cb : current.Children) {
    sum += cb.second + (cb.second * totalBagCount(bags, bags[cb.first]));
  }

  return sum;
}

int main(int argc, char* argv[])
{
  const std::string targetColor = "shiny gold";
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

  std::cout << "Total possible outermost bags: " << totalBagCount(bags, bags[targetColor]) << std::endl;

  return 0;
}
