//
//  SafeCollectionAccessTests.swift
//  Safe Collection Access
//
//  Created by Ben Leggiero on 2019-12-06.
//  Copyright © 2019 Ben Leggiero BH-1-PS.
//

import XCTest
@testable import SafeCollectionAccess



final class SafeCollectionAccessTests: XCTestCase {
    
    // MARK: - [orNil:]
    
    func testSubscript_orNil() {
        
        // MARK: Access
        
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
        
        
        XCTAssertEqual(helloWorld[orNil: helloWorld.startIndex], "H")
        XCTAssertEqual(helloWorld[orNil: helloWorld.index(helloWorld.startIndex, offsetBy: 0)], "H")
        XCTAssertEqual(helloWorld[orNil: helloWorld.index(helloWorld.startIndex, offsetBy: 1)], "e")
        XCTAssertEqual(helloWorld[orNil: helloWorld.index(helloWorld.startIndex, offsetBy: 12)], "!")
        XCTAssertEqual(helloWorld[orNil: helloWorld.index(helloWorld.startIndex, offsetBy: 11)], "d")
        
        
        // MARK: Mutation
        
        mutationTest { copy in
            copy[orNil: 0] = 42
            XCTAssertEqual(42, copy[orNil: 0])
            XCTAssertEqual(42, copy[       0])
            
            copy[orNil: 0] = nil
            XCTAssertEqual([1, 2, 3, 5], copy)
        }
        mutationTest { copy in
            copy[orNil: 1] = 42
            XCTAssertEqual(42, copy[orNil: 1])
            XCTAssertEqual(42, copy[       1])
            
            copy[orNil: 1] = nil
            XCTAssertEqual([1, 2, 3, 5], copy)
        }
        mutationTest { copy in
            copy[orNil: 2] = 42
            XCTAssertEqual(42, copy[orNil: 2])
            XCTAssertEqual(42, copy[       2])
            
            copy[orNil: 2] = nil
            XCTAssertEqual([1, 1, 3, 5], copy)
        }
        mutationTest { copy in
            copy[orNil: 3] = 42
            XCTAssertEqual(42, copy[orNil: 3])
            XCTAssertEqual(42, copy[       3])
            
            copy[orNil: 3] = nil
            XCTAssertEqual([1, 1, 2, 5], copy)
        }
        mutationTest { copy in
            copy[orNil: 4] = 42
            XCTAssertEqual(42, copy[orNil: 4])
            XCTAssertEqual(42, copy[       4])
            
            copy[orNil: 4] = nil
            XCTAssertEqual([1, 1, 2, 3], copy)
        }
        
        
        mutationTest { copy in
            copy[orNil: -20] = 42
            XCTAssertEqual(copy, first5Fibonacci)
            
            copy[orNil: -20] = nil
            XCTAssertEqual(copy, first5Fibonacci)
        }
        mutationTest { copy in
            copy[orNil: -2] = 42
            XCTAssertEqual(copy, first5Fibonacci)
            
            copy[orNil: -2] = nil
            XCTAssertEqual(copy, first5Fibonacci)
        }
        mutationTest { copy in
            copy[orNil: -1] = 42
            XCTAssertEqual(copy, first5Fibonacci)
            
            copy[orNil: -1] = nil
            XCTAssertEqual(copy, first5Fibonacci)
        }
        mutationTest { copy in
            copy[orNil: 5] = 42
            XCTAssertEqual(copy, first5Fibonacci)
            
            copy[orNil: 5] = nil
            XCTAssertEqual(copy, first5Fibonacci)
        }
        mutationTest { copy in
            copy[orNil: 6] = 42
            XCTAssertEqual(copy, first5Fibonacci)
            
            copy[orNil: 6] = nil
            XCTAssertEqual(copy, first5Fibonacci)
        }
        mutationTest { copy in
            copy[orNil: 20] = 42
            XCTAssertEqual(copy, first5Fibonacci)
            
            copy[orNil: 20] = nil
            XCTAssertEqual(copy, first5Fibonacci)
        }
    }
    
    
    
    // MARK: - [clamping:]
    
    // MARK: Multi-elemet arrays
    
    func testSubscript_clamping_multiElementArrays() {
        
        // MARK: • Access
        
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
        
        
        // MARK: • Mutation
        
        mutationTest { copy in
            copy[clamping: 0] = 42
            XCTAssertEqual(42, copy[clamping: 0])
            XCTAssertEqual(42, copy[          0])
            
            copy[clamping: 0] = nil
            XCTAssertEqual([1, 2, 3, 5], copy)
        }
        mutationTest { copy in
            copy[clamping: 1] = 42
            XCTAssertEqual(42, copy[clamping: 1])
            XCTAssertEqual(42, copy[          1])
            
            copy[clamping: 1] = nil
            XCTAssertEqual([1, 2, 3, 5], copy)
        }
        mutationTest { copy in
            copy[clamping: 2] = 42
            XCTAssertEqual(42, copy[clamping: 2])
            XCTAssertEqual(42, copy[          2])
            
            copy[clamping: 2] = nil
            XCTAssertEqual([1, 1, 3, 5], copy)
        }
        mutationTest { copy in
            copy[clamping: 3] = 42
            XCTAssertEqual(42, copy[clamping: 3])
            XCTAssertEqual(42, copy[          3])
            
            copy[clamping: 3] = nil
            XCTAssertEqual([1, 1, 2, 5], copy)
        }
        mutationTest { copy in
            copy[clamping: 4] = 42
            XCTAssertEqual(42, copy[clamping: 4])
            XCTAssertEqual(42, copy[          4])
            
            copy[clamping: 4] = nil
            XCTAssertEqual([1, 1, 2, 3], copy)
        }
        
        
        mutationTest { copy in
            copy[clamping: -20] = 42
            XCTAssertEqual([42, 1, 2, 3, 5], copy)
            
            copy[clamping: -20] = nil
            XCTAssertEqual([1, 2, 3, 5], copy)
        }
        mutationTest { copy in
            copy[clamping: -2] = 42
            XCTAssertEqual([42, 1, 2, 3, 5], copy)
            
            copy[clamping: -2] = nil
            XCTAssertEqual([1, 2, 3, 5], copy)
        }
        mutationTest { copy in
            copy[clamping: -1] = 42
            XCTAssertEqual([42, 1, 2, 3, 5], copy)
            
            copy[clamping: -1] = nil
            XCTAssertEqual([1, 2, 3, 5], copy)
        }
        mutationTest { copy in
            copy[clamping: 5] = 42
            XCTAssertEqual([1, 1, 2, 3, 42], copy)
            
            copy[clamping: 5] = nil
            XCTAssertEqual([1, 1, 2, 3], copy)
        }
        mutationTest { copy in
            copy[clamping: 6] = 42
            XCTAssertEqual([1, 1, 2, 3, 42], copy)
            
            copy[clamping: 6] = nil
            XCTAssertEqual([1, 1, 2, 3], copy)
        }
        mutationTest { copy in
            copy[clamping: 20] = 42
            XCTAssertEqual([1, 1, 2, 3, 42], copy)
            
            copy[clamping: 20] = nil
            XCTAssertEqual([1, 1, 2, 3], copy)
        }
    }
    
    
    // MARK: Single-elemet arrays
    
    func testSubscript_clamping_singleElementArrays() {
        
        let collectionOfOne = [42]
        
        
        // MARK: • Access
        
        XCTAssertEqual(42, collectionOfOne[clamping: -2])
        XCTAssertEqual(42, collectionOfOne[clamping: -1])
        XCTAssertEqual(42, collectionOfOne[clamping: 0])
        XCTAssertEqual(42, collectionOfOne[clamping: 1])
        XCTAssertEqual(42, collectionOfOne[clamping: 2])
        
        
        // MARK: • Mutation
        
        mutationTest(with: collectionOfOne) { copy in
            copy[clamping: -20] = 42
            XCTAssertEqual([42], copy)
            
            copy[clamping: -20] = nil
            XCTAssertEqual([], copy)
        }
        mutationTest(with: collectionOfOne) { copy in
            copy[clamping: -2] = 42
            XCTAssertEqual([42], copy)
            
            copy[clamping: -2] = nil
            XCTAssertEqual([], copy)
        }
        mutationTest(with: collectionOfOne) { copy in
            copy[clamping: -1] = 42
            XCTAssertEqual([42], copy)
            
            copy[clamping: -1] = nil
            XCTAssertEqual([], copy)
        }
        mutationTest(with: collectionOfOne) { copy in
            copy[clamping: 0] = 42
            XCTAssertEqual([42], copy)
            
            copy[clamping: 0] = nil
            XCTAssertEqual([], copy)
        }
        mutationTest(with: collectionOfOne) { copy in
            copy[clamping: 1] = 42
            XCTAssertEqual([42], copy)
            
            copy[clamping: 1] = nil
            XCTAssertEqual([], copy)
        }
        mutationTest(with: collectionOfOne) { copy in
            copy[clamping: 2] = 42
            XCTAssertEqual([42], copy)
            
            copy[clamping: 2] = nil
            XCTAssertEqual([], copy)
        }
        mutationTest(with: collectionOfOne) { copy in
            copy[clamping: 20] = 42
            XCTAssertEqual([42], copy)
            
            copy[clamping: 20] = nil
            XCTAssertEqual([], copy)
        }
    }
    
    
    // MARK: Empty arrays
    
    func testSubscript_clamping_emptyArrays() {
        
        let emptyCollection = [Int]()
        
        
        // MARK: • Access
        
        XCTAssertNil(emptyCollection[clamping: -2])
        XCTAssertNil(emptyCollection[clamping: -1])
        XCTAssertNil(emptyCollection[clamping: 0])
        XCTAssertNil(emptyCollection[clamping: 1])
        XCTAssertNil(emptyCollection[clamping: 2])
        
        
        // MARK: • Mutation
        
        mutationTest(with: emptyCollection) { copy in
            copy[clamping: -20] = 42
            XCTAssertEqual([], copy)
            
            copy[clamping: -20] = nil
            XCTAssertEqual([], copy)
        }
        mutationTest(with: emptyCollection) { copy in
            copy[clamping: -2] = 42
            XCTAssertEqual([], copy)
            
            copy[clamping: -2] = nil
            XCTAssertEqual([], copy)
        }
        mutationTest(with: emptyCollection) { copy in
            copy[clamping: -1] = 42
            XCTAssertEqual([], copy)
            
            copy[clamping: -1] = nil
            XCTAssertEqual([], copy)
        }
        mutationTest(with: emptyCollection) { copy in
            copy[clamping: 0] = 42
            XCTAssertEqual([], copy)
            
            copy[clamping: 0] = nil
            XCTAssertEqual([], copy)
        }
        mutationTest(with: emptyCollection) { copy in
            copy[clamping: 1] = 42
            XCTAssertEqual([], copy)
            
            copy[clamping: 1] = nil
            XCTAssertEqual([], copy)
        }
        mutationTest(with: emptyCollection) { copy in
            copy[clamping: 2] = 42
            XCTAssertEqual([], copy)
            
            copy[clamping: 2] = nil
            XCTAssertEqual([], copy)
        }
        mutationTest(with: emptyCollection) { copy in
            copy[clamping: 20] = 42
            XCTAssertEqual([], copy)
            
            copy[clamping: 20] = nil
            XCTAssertEqual([], copy)
        }
    }
    
    
    static var allTests = [
        ("testSubscript_orNil", testSubscript_orNil),
        ("testSubscript_clamping_multiElementArrays", testSubscript_clamping_multiElementArrays),
        ("testSubscript_clamping_singleElementArrays", testSubscript_clamping_singleElementArrays),
        ("testSubscript_clamping_emptyArrays", testSubscript_clamping_emptyArrays),
    ]
}
