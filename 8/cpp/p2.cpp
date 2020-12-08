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

bool execute(std::vector<Instr>& program, int ln, int& acc, std::vector<Instr>* probInstr = nullptr)
{
  if (ln == program.size()) return true;

  // Ampersands, baby
  auto& line = program[ln];

  if (line.called > 0) return false;

  line.called++;

  if (line.instr == "nop") {
    if (probInstr != nullptr) probInstr->push_back(line);
    return execute(program, ln + 1, acc, probInstr);
  } else if (line.instr == "acc") {
    acc += line.param;
    return execute(program, ln + 1, acc, probInstr);
  } else {
    if (probInstr != nullptr) probInstr->push_back(line);
    return execute(program, ln + line.param, acc, probInstr);
  }
}

int main(int argc, char* argv[])
{
  std::vector<Instr> program;

  for (std::string line; std::getline(std::cin, line); ) {
    auto instr = line.substr(0, 3);
    auto param = std::stoi(line.substr(4));

    program.push_back(Instr{ line, program.size(), instr, param, 0 });
  }

  int acc = 0;
  std::vector<Instr> probInstr;

  execute(program, 0, acc, &probInstr);

  for (int i = 0; i < program.size(); i++) {
    program[i].called = 0;
  }

  for (const auto& v : probInstr) {
    auto newProgram = program;
    acc = 0;

    if (v.instr == "jmp") newProgram[v.ln].instr = "nop";
    else newProgram[v.ln].instr = "jmp";

    if (execute(newProgram, 0, acc)) {
      break;
    }
  }

  std::cout << "Accumulator: " << acc << std::endl;

  return 0;
}
