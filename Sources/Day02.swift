import Algorithms
import Parsing

struct Day02: AdventDay {
  var data: String

  struct LevelsParser: Parser {
    var body: some Parser<Substring, [[Int]]> {
      Many {
        Many(1...) {
          Int.parser()
        } separator: {
          Whitespace(.horizontal)
        }
      } separator: {
        "\n"
      } terminator: {
        "\n"
      }
    }
  }

  func isSafe(_ report: [Int]) -> Bool {
    var sign: Int?
    for (prev, next) in zip(report, report.dropFirst()) {
      let diff = next - prev
      if abs(diff) > 3 { return false }
      if sign == nil {
        sign = diff.signum()
      } else if sign != diff.signum() {
        return false
      }
    }
    return true
  }
  
  func part1() throws -> Int {
    try LevelsParser().parse(data)
      .count(where: isSafe)
  }
  
  func isSafeDampened(_ report: [Int]) -> Bool {
    if isSafe(report) { return true }
    
    for idx in report.indices {
      var modifiedReport = report
      modifiedReport.remove(at: idx)
      if isSafe(modifiedReport) {
        return true
      }
    }
    
    return false
  }

  func part2() throws -> Int {
    try LevelsParser().parse(data)
      .count(where: isSafeDampened)
  }
}
