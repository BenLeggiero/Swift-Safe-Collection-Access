//
//  RangesOrNilTests.swift
//  Safe Collection Access
//
//  Created by Ben Leggiero on 2020-05-20.
//  Copyright © 2020 Ben Leggiero BH-1-PS.
//

import XCTest
@testable import SafeCollectionAccess



internal let first5Fibonacci = [1, 1, 2, 3, 5]



final class RangeOrNilTests: XCTestCase {
    
    
    func testSubscriptOrNil_Range() {
        XCTAssertEqual(first5Fibonacci[orNil: 0..<5], [1, 1, 2, 3, 5])
        XCTAssertEqual(first5Fibonacci[orNil: 1..<5], [1, 2, 3, 5])
        XCTAssertEqual(first5Fibonacci[orNil: 2..<5], [2, 3, 5])
        XCTAssertEqual(first5Fibonacci[orNil: 3..<5], [3, 5])
        XCTAssertEqual(first5Fibonacci[orNil: 4..<5], [5])
        XCTAssertEqual(first5Fibonacci[orNil: 5..<5], [])
        
        XCTAssertEqual(first5Fibonacci[orNil: 0..<5], [1, 1, 2, 3, 5])
        XCTAssertEqual(first5Fibonacci[orNil: 0..<4], [1, 1, 2, 3])
        XCTAssertEqual(first5Fibonacci[orNil: 0..<3], [1, 1, 2])
        XCTAssertEqual(first5Fibonacci[orNil: 0..<2], [1, 1])
        XCTAssertEqual(first5Fibonacci[orNil: 0..<1], [1])
        XCTAssertEqual(first5Fibonacci[orNil: 0..<0], [])
        
        XCTAssertEqual(first5Fibonacci[orNil: 2..<2], [])
        
        
        XCTAssertEqual(first5Fibonacci[orNil: 0..<5], first5Fibonacci[0..<5])
        XCTAssertEqual(first5Fibonacci[orNil: 1..<5], first5Fibonacci[1..<5])
        XCTAssertEqual(first5Fibonacci[orNil: 2..<5], first5Fibonacci[2..<5])
        XCTAssertEqual(first5Fibonacci[orNil: 3..<5], first5Fibonacci[3..<5])
        XCTAssertEqual(first5Fibonacci[orNil: 4..<5], first5Fibonacci[4..<5])
        XCTAssertEqual(first5Fibonacci[orNil: 5..<5], first5Fibonacci[5..<5])
        
        XCTAssertEqual(first5Fibonacci[orNil: 0..<5], first5Fibonacci[0..<5])
        XCTAssertEqual(first5Fibonacci[orNil: 0..<4], first5Fibonacci[0..<4])
        XCTAssertEqual(first5Fibonacci[orNil: 0..<3], first5Fibonacci[0..<3])
        XCTAssertEqual(first5Fibonacci[orNil: 0..<2], first5Fibonacci[0..<2])
        XCTAssertEqual(first5Fibonacci[orNil: 0..<1], first5Fibonacci[0..<1])
        XCTAssertEqual(first5Fibonacci[orNil: 0..<0], first5Fibonacci[0..<0])
        
        XCTAssertEqual(first5Fibonacci[orNil: 2..<2], first5Fibonacci[2..<2])
        
        
        XCTAssertNil(first5Fibonacci[orNil:  -1 ..<  0])
        XCTAssertNil(first5Fibonacci[orNil:  -1 ..<  2])
        XCTAssertNil(first5Fibonacci[orNil:   0 ..<  6])
        XCTAssertNil(first5Fibonacci[orNil:   2 ..<  6])
        XCTAssertNil(first5Fibonacci[orNil: -20 ..< -10])
        XCTAssertNil(first5Fibonacci[orNil:   7 ..<  9])
        
        
        mutationTest { copy1, copy2 in
            copy2[       1..<3] = [9]
            copy1[orNil: 1..<3] = [9]
            
            XCTAssertEqual(copy1, [1, 9, 3, 5])
            XCTAssertEqual(copy1, copy2)
        }
        
        mutationTest { copy1, copy2 in
            copy2[       1..<3] = [7, 8, 9]
            copy1[orNil: 1..<3] = [7, 8, 9]
            
            XCTAssertEqual(copy1, [1, 7, 8, 9, 3, 5])
            XCTAssertEqual(copy1, copy2)
        }
        
        mutationTest { copy in
            copy[orNil: 0 ..< 5] = [9]
            XCTAssertEqual(copy, [9])
        }
        
        
        mutationTest { copy in
            copy[orNil: -1 ..< 0] = [9]
            XCTAssertEqual(copy, first5Fibonacci)
        }
        
        mutationTest { copy in
            copy[orNil: 0 ..< 6] = [9]
            XCTAssertEqual(copy, first5Fibonacci)
        }
    }
    
    
    func testSubscriptOrNil_ClosedRange() {
        XCTAssertEqual(first5Fibonacci[orNil: 0...4], [1, 1, 2, 3, 5])
        XCTAssertEqual(first5Fibonacci[orNil: 1...4], [1, 2, 3, 5])
        XCTAssertEqual(first5Fibonacci[orNil: 2...4], [2, 3, 5])
        XCTAssertEqual(first5Fibonacci[orNil: 3...4], [3, 5])
        XCTAssertEqual(first5Fibonacci[orNil: 4...4], [5])

        XCTAssertEqual(first5Fibonacci[orNil: 0...4], [1, 1, 2, 3, 5])
        XCTAssertEqual(first5Fibonacci[orNil: 0...3], [1, 1, 2, 3])
        XCTAssertEqual(first5Fibonacci[orNil: 0...2], [1, 1, 2])
        XCTAssertEqual(first5Fibonacci[orNil: 0...1], [1, 1])
        XCTAssertEqual(first5Fibonacci[orNil: 0...0], [1])

        XCTAssertEqual(first5Fibonacci[orNil: 2...2], [2])


        XCTAssertEqual(first5Fibonacci[orNil: 0...4], first5Fibonacci[0...4])
        XCTAssertEqual(first5Fibonacci[orNil: 1...4], first5Fibonacci[1...4])
        XCTAssertEqual(first5Fibonacci[orNil: 2...4], first5Fibonacci[2...4])
        XCTAssertEqual(first5Fibonacci[orNil: 3...4], first5Fibonacci[3...4])
        XCTAssertEqual(first5Fibonacci[orNil: 4...4], first5Fibonacci[4...4])

        XCTAssertEqual(first5Fibonacci[orNil: 0...4], first5Fibonacci[0...4])
        XCTAssertEqual(first5Fibonacci[orNil: 0...3], first5Fibonacci[0...3])
        XCTAssertEqual(first5Fibonacci[orNil: 0...2], first5Fibonacci[0...2])
        XCTAssertEqual(first5Fibonacci[orNil: 0...1], first5Fibonacci[0...1])
        XCTAssertEqual(first5Fibonacci[orNil: 0...0], first5Fibonacci[0...0])

        XCTAssertEqual(first5Fibonacci[orNil: 2...2], first5Fibonacci[2...2])


        XCTAssertNil(first5Fibonacci[orNil:  -1 ...  0])
        XCTAssertNil(first5Fibonacci[orNil:  -1 ...  2])
        XCTAssertNil(first5Fibonacci[orNil:  -1 ...  4])
        XCTAssertNil(first5Fibonacci[orNil:  -1 ...  5])
        XCTAssertNil(first5Fibonacci[orNil:   0 ...  5])
        XCTAssertNil(first5Fibonacci[orNil:   1 ...  5])
        XCTAssertNil(first5Fibonacci[orNil:   2 ...  5])
        XCTAssertNil(first5Fibonacci[orNil:   3 ...  5])
        XCTAssertNil(first5Fibonacci[orNil:   4 ...  5])
        XCTAssertNil(first5Fibonacci[orNil:   5 ...  5])
        XCTAssertNil(first5Fibonacci[orNil:   0 ...  6])
        XCTAssertNil(first5Fibonacci[orNil:   2 ...  6])
        XCTAssertNil(first5Fibonacci[orNil: -20 ... -10])
        XCTAssertNil(first5Fibonacci[orNil:   7 ...  9])
        
        
        mutationTest { copy1, copy2 in
            copy2[       1...3] = [9]
            copy1[orNil: 1...3] = [9]
            
            XCTAssertEqual(copy1, [1, 9, 5])
            XCTAssertEqual(copy1, copy2)
        }
        
        mutationTest { copy in
            copy[orNil: 0 ... 4] = [9]
            XCTAssertEqual(copy, [9])
        }
        
        mutationTest { copy in
            copy[orNil: 5 ... 5] = [9]
            XCTAssertEqual(copy, first5Fibonacci)
        }
        
        
        
        mutationTest { copy in
            copy[orNil: -1 ... 0] = [9]
            XCTAssertEqual(copy, first5Fibonacci)
        }
        
        mutationTest { copy in
            copy[orNil: -1 ... 2] = [9]
            XCTAssertEqual(copy, first5Fibonacci)
        }
        
        mutationTest { copy in
            copy[orNil: -20 ... 0] = [9]
            XCTAssertEqual(copy, first5Fibonacci)
        }
        
        mutationTest { copy in
            copy[orNil: -20 ... 2] = [9]
            XCTAssertEqual(copy, first5Fibonacci)
        }
        
        mutationTest { copy in
            copy[orNil: 0 ... 5] = [9]
            XCTAssertEqual(copy, first5Fibonacci)
        }
        
        mutationTest { copy in
            copy[orNil: 0 ... 6] = [9]
            XCTAssertEqual(copy, first5Fibonacci)
        }
    }
    
    
    func testSubscriptOrNil_PartialRangeFrom() {
        XCTAssertEqual(first5Fibonacci[orNil: 0...], [1, 1, 2, 3, 5])
        XCTAssertEqual(first5Fibonacci[orNil: 1...], [1, 2, 3, 5])
        XCTAssertEqual(first5Fibonacci[orNil: 2...], [2, 3, 5])
        XCTAssertEqual(first5Fibonacci[orNil: 3...], [3, 5])
        XCTAssertEqual(first5Fibonacci[orNil: 4...], [5])
        XCTAssertEqual(first5Fibonacci[orNil: 5...], [])

        XCTAssertEqual(first5Fibonacci[orNil: 0...], first5Fibonacci[0...])
        XCTAssertEqual(first5Fibonacci[orNil: 1...], first5Fibonacci[1...])
        XCTAssertEqual(first5Fibonacci[orNil: 2...], first5Fibonacci[2...])
        XCTAssertEqual(first5Fibonacci[orNil: 3...], first5Fibonacci[3...])
        XCTAssertEqual(first5Fibonacci[orNil: 4...], first5Fibonacci[4...])
        XCTAssertEqual(first5Fibonacci[orNil: 5...], first5Fibonacci[5...])

        XCTAssertNil(first5Fibonacci[orNil: (  6)...])
        XCTAssertNil(first5Fibonacci[orNil: ( -1)...])
        XCTAssertNil(first5Fibonacci[orNil: (-20)...])
        XCTAssertNil(first5Fibonacci[orNil: (  7)...])
        
        
        
        mutationTest { copy1, copy2 in
            copy2[       1...] = [9]
            copy1[orNil: 1...] = [9]
            
            XCTAssertEqual(copy1, [1, 9])
            XCTAssertEqual(copy1, copy2)
        }
        
        mutationTest { copy in
            copy[orNil: 0...] = [9]
            XCTAssertEqual(copy, [9])
        }
        
        mutationTest { copy in
            copy[orNil: 1...] = [9]
            XCTAssertEqual(copy, [1, 9])
        }
        
        mutationTest { copy in
            copy[orNil: 2...] = [9]
            XCTAssertEqual(copy, [1, 1, 9])
        }
        
        mutationTest { copy in
            copy[orNil: 3...] = [9]
            XCTAssertEqual(copy, [1, 1, 2, 9])
        }
        
        mutationTest { copy in
            copy[orNil: 4...] = [9]
            XCTAssertEqual(copy, [1, 1, 2, 3, 9])
        }
        
        mutationTest { copy in
            copy[orNil: 5...] = [9]
            XCTAssertEqual(copy, [1, 1, 2, 3, 5, 9])
        }
        
        
        
        mutationTest { copy in
            copy[orNil: 6...] = [9]
            XCTAssertEqual(copy, first5Fibonacci)
        }
        
        mutationTest { copy in
            copy[orNil: (-1)...] = [9]
            XCTAssertEqual(copy, first5Fibonacci)
        }
        
        mutationTest { copy in
            copy[orNil: (-20)...] = [9]
            XCTAssertEqual(copy, first5Fibonacci)
        }
    }
    
    
    func testSubscriptOrNil_PartialRangeUpTo() {
        XCTAssertEqual(first5Fibonacci[orNil: ..<5], [1, 1, 2, 3, 5])
        XCTAssertEqual(first5Fibonacci[orNil: ..<4], [1, 1, 2, 3])
        XCTAssertEqual(first5Fibonacci[orNil: ..<3], [1, 1, 2])
        XCTAssertEqual(first5Fibonacci[orNil: ..<2], [1, 1])
        XCTAssertEqual(first5Fibonacci[orNil: ..<1], [1])
        XCTAssertEqual(first5Fibonacci[orNil: ..<0], [])
        
        XCTAssertEqual(first5Fibonacci[orNil: ..<5], first5Fibonacci[..<5])
        XCTAssertEqual(first5Fibonacci[orNil: ..<4], first5Fibonacci[..<4])
        XCTAssertEqual(first5Fibonacci[orNil: ..<3], first5Fibonacci[..<3])
        XCTAssertEqual(first5Fibonacci[orNil: ..<2], first5Fibonacci[..<2])
        XCTAssertEqual(first5Fibonacci[orNil: ..<1], first5Fibonacci[..<1])
        XCTAssertEqual(first5Fibonacci[orNil: ..<0], first5Fibonacci[..<0])
        
        XCTAssertNil(first5Fibonacci[orNil: ..<(-1 )])
        XCTAssertNil(first5Fibonacci[orNil: ..<( 6 )])
        XCTAssertNil(first5Fibonacci[orNil: ..<(-10)])
        XCTAssertNil(first5Fibonacci[orNil: ..<( 9 )])
        
        
        
        mutationTest { copy1, copy2 in
            copy2[       ..<3] = [9]
            copy1[orNil: ..<3] = [9]
            
            XCTAssertEqual(copy1, [9, 3, 5])
            XCTAssertEqual(copy1, copy2)
        }
        
        mutationTest { copy in
            copy[orNil: ..<5] = [9]
            XCTAssertEqual(copy, [9])
        }
        
        mutationTest { copy in
            copy[orNil: ..<4] = [9]
            XCTAssertEqual(copy, [9, 5])
        }
        
        mutationTest { copy in
            copy[orNil: ..<3] = [9]
            XCTAssertEqual(copy, [9, 3, 5])
        }
        
        mutationTest { copy in
            copy[orNil: ..<2] = [9]
            XCTAssertEqual(copy, [9, 2, 3, 5])
        }
        
        mutationTest { copy in
            copy[orNil: ..<1] = [9]
            XCTAssertEqual(copy, [9, 1, 2, 3, 5])
        }
        
        mutationTest { copy1, copy2 in
            copy1[orNil: ..<0] = [9]
            copy2[       ..<0] = [9]
            XCTAssertEqual(copy1, [9, 1, 1, 2, 3, 5])
            XCTAssertEqual(copy1, copy2)
        }
        
        
        
        mutationTest { copy in
            copy[orNil: ..<6] = [9]
            XCTAssertEqual(copy, first5Fibonacci)
        }
        
        mutationTest { copy in
            copy[orNil: ..<20] = [9]
            XCTAssertEqual(copy, first5Fibonacci)
        }
        
        mutationTest { copy in
            copy[orNil: ..<(-1)] = [9]
            XCTAssertEqual(copy, first5Fibonacci)
        }
        
        mutationTest { copy in
            copy[orNil: ..<(-20)] = [9]
            XCTAssertEqual(copy, first5Fibonacci)
        }
    }
    
    
    func testSubscriptOrNil_PartialRangeUpThrough() {
        XCTAssertEqual(first5Fibonacci[orNil: ...4], [1, 1, 2, 3, 5])
        XCTAssertEqual(first5Fibonacci[orNil: ...3], [1, 1, 2, 3])
        XCTAssertEqual(first5Fibonacci[orNil: ...2], [1, 1, 2])
        XCTAssertEqual(first5Fibonacci[orNil: ...1], [1, 1])
        XCTAssertEqual(first5Fibonacci[orNil: ...0], [1])

        XCTAssertEqual(first5Fibonacci[orNil: ...4], first5Fibonacci[...4])
        XCTAssertEqual(first5Fibonacci[orNil: ...3], first5Fibonacci[...3])
        XCTAssertEqual(first5Fibonacci[orNil: ...2], first5Fibonacci[...2])
        XCTAssertEqual(first5Fibonacci[orNil: ...1], first5Fibonacci[...1])
        XCTAssertEqual(first5Fibonacci[orNil: ...0], first5Fibonacci[...0])

        XCTAssertNil(first5Fibonacci[orNil: ...( 5 )])
        XCTAssertNil(first5Fibonacci[orNil: ...( 6 )])
        XCTAssertNil(first5Fibonacci[orNil: ...(-10)])
        XCTAssertNil(first5Fibonacci[orNil: ...( 9 )])



        mutationTest { copy1, copy2 in
            copy2[       ...3] = [9]
            copy1[orNil: ...3] = [9]

            XCTAssertEqual(copy1, [9, 5])
            XCTAssertEqual(copy1, copy2)
        }

        mutationTest { copy in
            copy[orNil: ...4] = [9]
            XCTAssertEqual(copy, [9])
        }

        mutationTest { copy in
            copy[orNil: ...3] = [9]
            XCTAssertEqual(copy, [9, 5])
        }

        mutationTest { copy in
            copy[orNil: ...2] = [9]
            XCTAssertEqual(copy, [9, 3, 5])
        }

        mutationTest { copy in
            copy[orNil: ...1] = [9]
            XCTAssertEqual(copy, [9, 2, 3, 5])
        }

        mutationTest { copy in
            copy[orNil: ...0] = [9]
            XCTAssertEqual(copy, [9, 1, 2, 3, 5])
        }
        
        mutationTest { copy1, copy2 in
            copy1[orNil: ...(-1)] = [9]
            copy2[       ...(-1)] = [9]
            XCTAssertEqual(copy1, [9, 1, 1, 2, 3, 5])
            XCTAssertEqual(copy1, copy2)
        }
        
        
        
        mutationTest { copy in
            copy[orNil: ...6] = [9]
            XCTAssertEqual(copy, first5Fibonacci)
        }
        
        mutationTest { copy in
            copy[orNil: ...20] = [9]
            XCTAssertEqual(copy, first5Fibonacci)
        }
        
        mutationTest { copy in
            copy[orNil: ...(-20)] = [9]
            XCTAssertEqual(copy, first5Fibonacci)
        }
    }
    
    
    static var allTests = [
        ("testSubscriptOrNil_Range", testSubscriptOrNil_Range),
        ("testSubscriptOrNil_ClosedRange", testSubscriptOrNil_ClosedRange),
        ("testSubscriptOrNil_PartialRangeFrom", testSubscriptOrNil_PartialRangeFrom),
        ("testSubscriptOrNil_PartialRangeUpTo", testSubscriptOrNil_PartialRangeUpTo),
        ("testSubscriptOrNil_PartialRangeUpThrough", testSubscriptOrNil_PartialRangeUpThrough),
    ]
}



internal func mutationTest<Value>(with value: Value, do closure: (_ copy: inout Value) -> Void) {
    var copy = value
    closure(&copy)
}


internal func mutationTest(do test: (_ copy: inout [Int]) -> Void) {
    mutationTest(with: first5Fibonacci, do: test)
}


internal func mutationTest<Value>(with value: Value, do closure: (_ copy1: inout Value, _ copy2: inout Value) -> Void) {
    var copy1 = value
    var copy2 = value
    closure(&copy1, &copy2)
}


internal func mutationTest(do test: (_ copy1: inout [Int], _ copy2: inout [Int]) -> Void) {
    mutationTest(with: first5Fibonacci, do: test)
}
