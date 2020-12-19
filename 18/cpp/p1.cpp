#include <iostream>
#include <string>
#include <cctype>
#include <cstdlib>

int findBalancedParenthesisPosition(const std::string& statement)
{
  int count = 1;
  for (int i = 0; i < statement.size(); i++) {
    const char c = statement[i];

    if (c == '(') count++;
    else if (c == ')') {
      count--;
      
      if (count == 0) {
        return i;
      }
    }
  }

  return std::string::npos;
}

int evaluate(const std::string& statement)
{
  int res = 0;
  bool firstDigit = true;
  char op = '\0';
  int i = 0;

  while (i < statement.size()) {
    char c = statement[i];

    if (std::isdigit(c)) {
      c = c - '0';
      if (firstDigit) {
        firstDigit = false;
        res = c;
      } else if (op == '+') {
        res += c;
      } else if (op == '*') {
        res *= c;
      }
    } else if (c == '(') {
      auto length = findBalancedParenthesisPosition(statement.substr(i + 1));
      auto n = evaluate(statement.substr(i + 1, length));

      if (firstDigit) {
        firstDigit = false;
        res = n;
      } else if (op == '+') {
        res += n;
      } else if (op == '*') {
        res *= n;
      }

      i = (i + 1) + length;
    } else if (c == '+' || c == '*') {
      op = c;
    }

    i++;
  }

  return res;
}

int main(int argc, char* argv[])
{
  int sum = 0;

  for (std::string line; std::getline(std::cin, line); ) {
    auto n = evaluate(line);
    sum += n;
    std::cout << line << " = " << n << std::endl;
  }

  std::cout << "Total: " << sum << std::endl;

  return 0;
}
