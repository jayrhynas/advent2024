import Algorithms
import Parsing

struct Day03: AdventDay {
  var data: String

  struct MulParser: Parser {
    var body: some Parser<Substring, (Int, Int)> {
      "mul("
      Int.parser()
      ","
      Int.parser()
      ")"
    }
  }
  
  struct Part1InstructionParser: Parser {
    var body: some Parser<Substring, [(Int, Int)]> {
      Many(into: []) { (pairs: inout [(Int, Int)], new: (Int, Int)?) in
        if let value = new {
          pairs.append(value)
        }
      } element: {
        OneOf(output: (Int, Int)?.self) {
          MulParser().map { Optional($0) }
          First().map { _ in nil }
        }
      }
    }
  }
  
  func part1() throws -> Int {
    try Part1InstructionParser().parse(data)
      .map { $0 * $1 }.reduce(0, +)
  }

  enum Instruction {
    case enable, disable, mul(Int, Int)
  }
  
  struct Part2InstructionParser: Parser {
    var body: some Parser<Substring, [Instruction]> {
      Many(into: []) { (pairs: inout [Instruction], new: Instruction?) in
        if let value = new {
          pairs.append(value)
        }
      } element: {
        OneOf(output: Instruction?.self) {
          MulParser().map { Optional(.mul($0.0, $0.1)) }
          "do()".map { Optional(.enable) }
          "don't()".map { Optional(.disable) }
          First().map { _ in nil }
        }
      }
    }
  }
  
  func part2() throws -> Int {
    let instructions = try Part2InstructionParser().parse(data)
    
    var enabled = true
    
    var sum = 0
    for instruction in instructions {
      switch instruction {
      case .enable: enabled = true
      case .disable: enabled = false
      case let .mul(x, y): sum += (enabled ? x * y : 0)
      }
    }
    
    return sum
  }
}
