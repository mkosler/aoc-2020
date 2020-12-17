#ifndef __RULES_H__
#define __RULES_H__

#include <string>
#include <map>
#include <functional>
#include <sstream>
#include <set>

class Rules
{
  private:
    std::map<std::string, std::function<bool(int)>> _rules;

  public:
    Rules() {}

    void Parse(std::string s)
    {
      std::stringstream ss;
      ss << s;

      for (std::string line; std::getline(ss, line); ) {
        auto pos = line.find(':');
        auto name = line.substr(pos - 1);

        std::stringstream ss2;
        ss2 << line.substr(pos);

        int b1, b2, b3, b4;
        ss2 >> b1;
        ss2 >> b2;
        ss2 >> b3;
        ss2 >> b4;

        _rules[name] = [=](int n) { return (b1 <= n && n <= b2) || (b3 <= n && n <= b4); };
      }
    }

    bool IsValid(int n)
    {
      for (const auto& kvp : _rules) {
        if (kvp.second(n)) return true;
      }

      return false;
    }

    int Count() { return _rules.size(); }

    std::set<std::string> GetValidRulesFor(int n)
    {
      std::set<std::string> valids;

      for (const auto& kvp : _rules) {
        if (kvp.second(n)) valids.insert(kvp.first);
      }

      return valids;
    }
};

#endif
