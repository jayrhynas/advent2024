import Algorithms
import Parsing

struct Day01: AdventDay {
  var data: String

  struct ListsParser: Parser {
    var body: some Parser<Substring, ([Int], [Int])> {
      Many(into: ([], [])) { (lists: inout Output, numbers: (Int, Int)) in
        lists.0.append(numbers.0)
        lists.1.append(numbers.1)
      } element: {
        Int.parser()
        Whitespace()
        Int.parser()
      } separator: {
        Whitespace()
      } terminator: {
        Whitespace()
      }
    }
  }

  func part1() throws -> Int {
    let lists = try ListsParser().parse(data)

    return zip(lists.0.sorted(), lists.1.sorted()).reduce(0) {
      $0 + abs($1.0 - $1.1)
    }
  }

  func part2() throws -> Int {
    let lists = try ListsParser().parse(data)
    let counts = lists.1.reduce(into: [Int: Int]()) { $0[$1, default: 0] += 1 }
    
    return lists.0.reduce(0) {
      $0 + $1 * counts[$1, default: 0]
    }
  }
}
