//
//  Safe Collection Access.swift
//  Safe Collection Access
//
//  Created by Ben Leggiero on 2019-12-06.
//  Copyright © 2019 Ben Leggiero BH-1-PS.
//



public extension RandomAccessCollection {
    
    /// Safely access this collection. If the index you pass is not in this collection, then `nil` is returned.
    ///
    /// If you don't like the `orNil` syntax, you may also use `[safe:]`.
    ///
    /// - Parameter index: The index of the element to retrieve, or an index outside this collection
    /// - Returns: The element which is in this collection at the given index, or `nil` if it's outside this collection
    @inlinable
    subscript(orNil index: Index) -> Element? {
        return indices.contains(index) ? self[index] : nil
    }
    
    
    /// Safely access this collection. If the index you pass is not in this collection, then `nil` is returned.
    ///
    /// This is an inlined alias to `[orNil:]`.
    ///
    /// - Parameter index: The index of the element to retrieve, or an index outside this collection
    /// - Returns: The element which is in this collection at the given index, or `nil` if it's outside this collection
    @inline(__always)
    subscript(safe index: Index) -> Element? {
        return self[orNil: index]
    }
}
