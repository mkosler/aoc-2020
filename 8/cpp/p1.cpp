#include <iostream>
#include <vector>
#include <string>

struct Instr
{
  std::string line;
  int ln;
  std::string instr;
  int param;
  int called;
};

int execute(std::vector<Instr>& program, int ln, int acc)
{
  // Ampersands, baby
  auto& line = program[ln];

  if (line.called > 0) return acc;

  line.called++;

  if (line.instr == "nop") return execute(program, ln + 1, acc);
  else if (line.instr == "acc") return execute(program, ln + 1, acc + line.param);
  else return execute(program, ln + line.param, acc);
}

int main(int argc, char* argv[])
{
  std::vector<Instr> program;

  for (std::string line; std::getline(std::cin, line); ) {
    auto instr = line.substr(0, 3);
    auto param = std::stoi(line.substr(4));

    program.push_back(Instr{ line, program.size(), instr, param, 0 });
  }

  std::cout << "Accumulator on first repeat: " << execute(program, 0, 0) << std::endl;

  return 0;
}
