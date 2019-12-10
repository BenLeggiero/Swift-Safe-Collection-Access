//
//  Safe Collection Access.swift
//  Safe Collection Access
//
//  Created by Ben Leggiero on 2019-12-06.
//  Copyright © 2019 Ben Leggiero BH-1-PS.
//

import XCTest
@testable import SafeCollectionAccess



final class SafeCollectionAccessTests: XCTestCase {
    
    let first5Fibonacci = [1, 1, 2, 3, 5]
    
    
    func testSubscriptOrNil() {
        XCTAssertEqual(1, first5Fibonacci[orNil: 0])
        XCTAssertEqual(1, first5Fibonacci[orNil: 1])
        XCTAssertEqual(2, first5Fibonacci[orNil: 2])
        XCTAssertEqual(3, first5Fibonacci[orNil: 3])
        XCTAssertEqual(5, first5Fibonacci[orNil: 4])
        
        XCTAssertNotEqual(first5Fibonacci[orNil: -1], first5Fibonacci[orNil: 0])
        XCTAssertEqual(first5Fibonacci[orNil: 0], first5Fibonacci[orNil: 1])
        XCTAssertNotEqual(first5Fibonacci[orNil: 1], first5Fibonacci[orNil: 2])
        XCTAssertNotEqual(first5Fibonacci[orNil: 2], first5Fibonacci[orNil: 3])
        XCTAssertNotEqual(first5Fibonacci[orNil: 3], first5Fibonacci[orNil: 4])
        
        XCTAssertNil(first5Fibonacci[orNil: -2])
        XCTAssertNil(first5Fibonacci[orNil: -1])
        XCTAssertNotNil(first5Fibonacci[orNil: 0])
        XCTAssertNotNil(first5Fibonacci[orNil: 1])
        XCTAssertNotNil(first5Fibonacci[orNil: 2])
        XCTAssertNotNil(first5Fibonacci[orNil: 3])
        XCTAssertNotNil(first5Fibonacci[orNil: 4])
        XCTAssertNil(first5Fibonacci[orNil: 5])
        XCTAssertNil(first5Fibonacci[orNil: 6])
    }
    
    
    func testSubscriptSafe() {
        XCTAssertEqual(1, first5Fibonacci[safe: 0])
        XCTAssertEqual(1, first5Fibonacci[safe: 1])
        XCTAssertEqual(2, first5Fibonacci[safe: 2])
        XCTAssertEqual(3, first5Fibonacci[safe: 3])
        XCTAssertEqual(5, first5Fibonacci[safe: 4])
        
        XCTAssertNotEqual(first5Fibonacci[safe: -1], first5Fibonacci[safe: 0])
        XCTAssertEqual(first5Fibonacci[safe: 0], first5Fibonacci[safe: 1])
        XCTAssertNotEqual(first5Fibonacci[safe: 1], first5Fibonacci[safe: 2])
        XCTAssertNotEqual(first5Fibonacci[safe: 2], first5Fibonacci[safe: 3])
        XCTAssertNotEqual(first5Fibonacci[safe: 3], first5Fibonacci[safe: 4])
        
        XCTAssertNil(first5Fibonacci[safe: -2])
        XCTAssertNil(first5Fibonacci[safe: -1])
        XCTAssertNotNil(first5Fibonacci[safe: 0])
        XCTAssertNotNil(first5Fibonacci[safe: 1])
        XCTAssertNotNil(first5Fibonacci[safe: 2])
        XCTAssertNotNil(first5Fibonacci[safe: 3])
        XCTAssertNotNil(first5Fibonacci[safe: 4])
        XCTAssertNil(first5Fibonacci[safe: 5])
        XCTAssertNil(first5Fibonacci[safe: 6])
    }
    
    
    func testSubscriptClamping() {
        XCTAssertEqual(1, first5Fibonacci[clamping: 0])
        XCTAssertEqual(1, first5Fibonacci[clamping: 1])
        XCTAssertEqual(2, first5Fibonacci[clamping: 2])
        XCTAssertEqual(3, first5Fibonacci[clamping: 3])
        XCTAssertEqual(5, first5Fibonacci[clamping: 4])
        
        XCTAssertEqual(first5Fibonacci[clamping: -1], first5Fibonacci[clamping: 0])
        XCTAssertEqual(first5Fibonacci[clamping: 0], first5Fibonacci[clamping: 1])
        XCTAssertNotEqual(first5Fibonacci[clamping: 1], first5Fibonacci[clamping: 2])
        XCTAssertNotEqual(first5Fibonacci[clamping: 2], first5Fibonacci[clamping: 3])
        XCTAssertNotEqual(first5Fibonacci[clamping: 3], first5Fibonacci[clamping: 4])
        
        XCTAssertNotNil(first5Fibonacci[clamping: -2])
        XCTAssertNotNil(first5Fibonacci[clamping: -1])
        XCTAssertNotNil(first5Fibonacci[clamping: 0])
        XCTAssertNotNil(first5Fibonacci[clamping: 1])
        XCTAssertNotNil(first5Fibonacci[clamping: 2])
        XCTAssertNotNil(first5Fibonacci[clamping: 3])
        XCTAssertNotNil(first5Fibonacci[clamping: 4])
        XCTAssertNotNil(first5Fibonacci[clamping: 5])
        XCTAssertNotNil(first5Fibonacci[clamping: 6])
        
        
        let collectionOfOne = [42]
        
        XCTAssertEqual(42, collectionOfOne[clamping: -2])
        XCTAssertEqual(42, collectionOfOne[clamping: -1])
        XCTAssertEqual(42, collectionOfOne[clamping: 0])
        XCTAssertEqual(42, collectionOfOne[clamping: 1])
        XCTAssertEqual(42, collectionOfOne[clamping: 2])
        
        
        let emptyCollection = [Int]()
        
        XCTAssertNil(emptyCollection[clamping: -2])
        XCTAssertNil(emptyCollection[clamping: -1])
        XCTAssertNil(emptyCollection[clamping: 0])
        XCTAssertNil(emptyCollection[clamping: 1])
        XCTAssertNil(emptyCollection[clamping: 2])
    }
    
    
    static var allTests = [
        ("testSubscriptOrNil", testSubscriptOrNil),
        ("testSubscriptSafe", testSubscriptSafe),
        ("testSubscriptClamping", testSubscriptClamping),
    ]
}
