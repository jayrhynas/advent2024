import Testing

@testable import AdventOfCode

struct Day02Tests {
  let data = """
  7 6 4 2 1
  1 2 7 8 9
  9 7 6 2 1
  1 3 2 4 5
  8 6 4 4 1
  1 3 6 7 9
  
  """


  @Test func testPart1() async throws {
    try #expect(Day02(data: data).part1() == 2)
  }

  @Test func testPart2() async throws {
    #expect(true)
  }
}
