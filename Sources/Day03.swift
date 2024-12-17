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
  
  struct InstructionParser: Parser {
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
    try InstructionParser().parse(data)
      .map { $0 * $1 }.reduce(0, +)
  }

  func part2() -> Int {
    return 0
  }
}
