//
//  Test Tools.swift
//  
//
//  Created by Ben Leggiero on 2021-06-10.
//

import Foundation



// MARK: - Shared values

internal let first5Fibonacci = [1, 1, 2, 3, 5]
internal let helloWorld = "Hello, World!"



// MARK: - Convenience functions

internal func mutationTest<Value>(with value: Value, do closure: (_ copy: inout Value) -> Void) {
    var copy = value
    closure(&copy)
}


internal func mutationTest(with value: String, do closure: (_ copy: inout String) -> Void) {
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


internal func mutationTest(with value: String, do closure: (_ copy1: inout String, _ copy2: inout String) -> Void) {
    var copy1 = value
    var copy2 = value
    closure(&copy1, &copy2)
}


internal func mutationTest(do test: (_ copy1: inout [Int], _ copy2: inout [Int]) -> Void) {
    mutationTest(with: first5Fibonacci, do: test)
}



// MARK: - Test conformance

extension String: RandomAccessCollection {
    public typealias SubSequence = Substring
}



extension Substring: RandomAccessCollection {
    public typealias SubSequence = Substring
}
