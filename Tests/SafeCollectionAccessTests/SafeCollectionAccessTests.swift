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
    
    func testSubscriptOrNil() {
        let first5Fibonacci = [1, 1, 2, 3, 5]

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
        let first5Fibonacci = [1, 1, 2, 3, 5]

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
    
    
    static var allTests = [
        ("testSubscriptOrNil", testSubscriptOrNil),
        ("testSubscriptSafe", testSubscriptSafe),
    ]
}
