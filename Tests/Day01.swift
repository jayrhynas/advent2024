import Testing

@testable import AdventOfCode

struct Day01Tests {
  let data = """
  3   4
  4   3
  2   5
  1   3
  3   9
  3   3
  """

  @Test func testPart1() async throws {
    try #expect(Day01(data: data).part1() == 11)
  }

  @Test func testPart2() async throws {
    #expect(true)
  }
}
