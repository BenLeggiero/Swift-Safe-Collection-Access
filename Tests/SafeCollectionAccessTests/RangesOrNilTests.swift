//
//  RangesOrNilTests.swift
//  Safe Collection Access
//
//  Created by Ben Leggiero on 2020-05-20.
//  Copyright © 2020 Ben Leggiero BH-1-PS.
//

import XCTest
@testable import SafeCollectionAccess



final class RangeOrNilTests: XCTestCase {
    
    let first5Fibonacci = [1, 1, 2, 3, 5]
    
    
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
        
        XCTAssertNil(first5Fibonacci[orNil:  -1 ..<  0])
        XCTAssertNil(first5Fibonacci[orNil:   0 ..<  6])
        XCTAssertNil(first5Fibonacci[orNil: -20 ..< -10])
        XCTAssertNil(first5Fibonacci[orNil:   7 ..<  9])
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
        
        XCTAssertNil(first5Fibonacci[orNil:  -1 ...  0])
        XCTAssertNil(first5Fibonacci[orNil:   0 ...  6])
        XCTAssertNil(first5Fibonacci[orNil: -20 ... -10])
        XCTAssertNil(first5Fibonacci[orNil:   7 ...  9])
    }
    
    
    func testSubscriptOrNil_PartialRangeFrom() {
        XCTAssertEqual(first5Fibonacci[orNil: 0...], [1, 1, 2, 3, 5])
        XCTAssertEqual(first5Fibonacci[orNil: 1...], [1, 2, 3, 5])
        XCTAssertEqual(first5Fibonacci[orNil: 2...], [2, 3, 5])
        XCTAssertEqual(first5Fibonacci[orNil: 3...], [3, 5])
        XCTAssertEqual(first5Fibonacci[orNil: 4...], [5])
        
        XCTAssertNil(first5Fibonacci[orNil: (  5)...])
        XCTAssertNil(first5Fibonacci[orNil: ( -1)...])
        XCTAssertNil(first5Fibonacci[orNil: (-20)...])
        XCTAssertNil(first5Fibonacci[orNil: (  7)...])
    }
    
    
    func testSubscriptOrNil_PartialRangeUpTo() {
        XCTAssertEqual(first5Fibonacci[orNil: ..<5], [1, 1, 2, 3, 5])
        XCTAssertEqual(first5Fibonacci[orNil: ..<4], [1, 1, 2, 3])
        XCTAssertEqual(first5Fibonacci[orNil: ..<3], [1, 1, 2])
        XCTAssertEqual(first5Fibonacci[orNil: ..<2], [1, 1])
        XCTAssertEqual(first5Fibonacci[orNil: ..<1], [1])
        
        XCTAssertNil(first5Fibonacci[orNil: ..<( 0 )])
        XCTAssertNil(first5Fibonacci[orNil: ..<( 6 )])
        XCTAssertNil(first5Fibonacci[orNil: ..<(-10)])
        XCTAssertNil(first5Fibonacci[orNil: ..<( 9 )])
    }
    
    
    func testSubscriptOrNil_PartialRangeUpThrough() {
        XCTAssertEqual(first5Fibonacci[orNil: ...4], [1, 1, 2, 3, 5])
        XCTAssertEqual(first5Fibonacci[orNil: ...3], [1, 1, 2, 3])
        XCTAssertEqual(first5Fibonacci[orNil: ...2], [1, 1, 2])
        XCTAssertEqual(first5Fibonacci[orNil: ...1], [1, 1])
        XCTAssertEqual(first5Fibonacci[orNil: ...0], [1])
        
        XCTAssertNil(first5Fibonacci[orNil: ...( 6 )])
        XCTAssertNil(first5Fibonacci[orNil: ...(-10)])
        XCTAssertNil(first5Fibonacci[orNil: ...( 9 )])
    }
    
    
    static var allTests = [
        ("testSubscriptOrNil_Range", testSubscriptOrNil_Range),
        ("testSubscriptOrNil_ClosedRange", testSubscriptOrNil_ClosedRange),
        ("testSubscriptOrNil_PartialRangeFrom", testSubscriptOrNil_PartialRangeFrom),
        ("testSubscriptOrNil_PartialRangeUpTo", testSubscriptOrNil_PartialRangeUpTo),
        ("testSubscriptOrNil_PartialRangeUpThrough", testSubscriptOrNil_PartialRangeUpThrough),
    ]
}
