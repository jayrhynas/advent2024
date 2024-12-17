import Testing

@testable import AdventOfCode

struct Day04Tests {

  let data = """
  MMMSXXMASM
  MSAMXMSMSA
  AMXSXMAAMM
  MSAMASMSMX
  XMASAMXAMM
  XXAMMXXAMA
  SMSMSASXSS
  SAXAMASAAA
  MAMMMXMMMM
  MXMXAXMASX
  """

  @Test func testPart1() async throws {
    try #expect(Day04(data: data).part1() == 18)
  }

  @Test func testPart2() async throws {
    try #expect(Day04(data: data).part2() == 9)
  }
}
