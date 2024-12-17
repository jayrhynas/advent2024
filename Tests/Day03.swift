import Testing

@testable import AdventOfCode

struct Day03Tests {
  let part1data = """
  xmul(2,4)%&mul[3,7]!@^do_not_mul(5,5)+mul(32,64]then(mul(11,8)mul(8,5))
  """


  @Test func testPart1() async throws {
    try #expect(Day03(data: part1data).part1() == 161)
  }

  let part2data = """
  xmul(2,4)&mul[3,7]!^don't()_mul(5,5)+mul(32,64](mul(11,8)undo()?mul(8,5))
  """
  
  @Test func testPart2() async throws {
    try #expect(Day03(data: part2data).part2() == 48)
  }
}
