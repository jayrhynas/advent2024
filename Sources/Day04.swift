import Algorithms
import Parsing

struct Day04: AdventDay {
  var data: String
  
  struct Coordinate {
    var r: Int
    var c: Int
    
    static func + (lhs: Coordinate, rhs: Coordinate) -> Coordinate {
      Coordinate(r: lhs.r + rhs.r, c: lhs.c + rhs.c)
    }
  }
  
  struct Grid {
    let characters: [[Character]]
    
    subscript(coordinate: Coordinate) -> Character? {
      guard characters.indices.contains(coordinate.r) else { return nil }
      let row = characters[coordinate.r]
      guard row.indices.contains(coordinate.c) else { return nil }
      return row[coordinate.c]
    }
    
    var coordinates: [Coordinate] {
      zip(characters, characters.indices).flatMap { (row, r) in
        row.indices.map { Coordinate(r: r, c: $0) }
      }
    }
  }
  
  struct GridParser: Parser {
    var body: some Parser<Substring, Grid> {
      Parse(Grid.init(characters:)) {
        Many {
          Many {
            Not { "\n" }
            First()
          }
        } separator: {
          "\n"
        }
      }
    }
  }
  
  enum Dir: CaseIterable {
    case n, nw, w, sw, s, se, e, ne
    
    var offset: Coordinate {
      switch self {
      case .n:  .init(r: -1, c: 0)
      case .nw: .init(r: -1, c: -1)
      case .w:  .init(r: 0, c: -1)
      case .sw: .init(r: 1, c: -1)
      case .s:  .init(r: 1, c: 0)
      case .se: .init(r: 1, c: 1)
      case .e:  .init(r: 0, c: 1)
      case .ne: .init(r: -1, c: 1)
      }
    }
  }
  
  func searchXMAS(_ grid: Grid, from index: Coordinate) -> Int {
    var count = 0
    
    dirLoop: for dir in Dir.allCases {
      var cur = index

      for char in ["M", "A", "S"] as [Character] {
        cur = cur + dir.offset
        if grid[cur] != char { continue dirLoop }
      }
      
      count += 1
    }
    
    return count
  }
  
  func part1() throws -> Int {
    let grid = try GridParser().parse(data)
    
    var total = 0
    for coord in grid.coordinates {
      guard grid[coord] == "X" else { continue }
      
      total += searchXMAS(grid, from: coord)
    }
    return total
  }

  func searchX_MAS(_ grid: Grid, from index: Coordinate) -> Int {
    let downDiag = (grid[index + Dir.nw.offset], grid[index + Dir.se.offset])
    let upDiag   = (grid[index + Dir.sw.offset], grid[index + Dir.ne.offset])
    
    guard (downDiag == ("M", "S") || downDiag == ("S", "M"))
       && (upDiag   == ("M", "S") || upDiag   == ("S", "M"))
    else {
      return 0
    }
    
    return 1
  }
  
  func part2() throws -> Int {
    let grid = try GridParser().parse(data)
    
    var total = 0
    for coord in grid.coordinates {
      guard grid[coord] == "A" else { continue }
      
      total += searchX_MAS(grid, from: coord)
    }
    return total
  }
}
