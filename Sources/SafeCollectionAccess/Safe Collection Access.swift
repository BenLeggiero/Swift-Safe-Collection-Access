//
//  Safe Collection Access.swift
//  Safe Collection Access
//
//  Created by Ben Leggiero on 2019-12-06.
//  Copyright © 2019 Ben Leggiero BH-1-PS.
//



// MARK: - `[orNil: ]` and `[safe: ]`

public extension RandomAccessCollection {
    
    /// Determines whether this collection has an item at the given index
    ///
    /// - Parameter index: An index that might be in this collection
    /// - Returns: `true` iff `index` points to an item that's in this collection
    func contains(index: Index) -> Bool {
        indices.contains(index)
    }
    
    
    /// Determines whether this collection contains all the indices in the given index
    ///
    /// This is a naïve iteration over all the indices in this collection
    ///
    /// - Complexity: O(n)
    ///
    /// - Parameter otherIndices: Some indices which might point to items in this collection
    /// - Returns: `false` if any of the given indices
    func contains<Indices>(allIn otherIndices: Indices) -> Bool
        where Indices: Sequence,
            Indices.Element == Index
    {
        otherIndices.allSatisfy { indices.contains($0) }
    }
    
    
    /// Safely access this collection. If the index you pass is not in this collection, then `nil` is returned.
    ///
    /// If you don't like the `orNil` syntax, you may also use `[safe:]`.
    ///
    /// - Parameter index: The index of the element to retrieve, or an index outside this collection
    /// - Returns: The element which is in this collection at the given index, or `nil` if it's outside this collection
    @inlinable
    subscript(orNil index: Index) -> Element? {
        return contains(index: index)
            ? self[index]
            : nil
    }
}



// MARK: - `[clamping: ]`

public extension RandomAccessCollection {
    
    /// Safely access this collection. If the index you pass is not in this collection, the closest extreme is
    /// returned. If this collection is empty (and thus there is no such extreme to return), then `nil` is returned.
    ///
    /// - Parameter index: The index of the element to retrieve, or an index outside this collection
    /// - Returns: The element which is in this collection at the given index, or the closest one if it's outside this
    ///            collection, or `nil` if this collection is empty
    @inlinable
    subscript(clamping index: Index) -> Element? {
        if isEmpty {
            return nil
        }
        else if index < startIndex {
            return first
        }
        else if index >= endIndex {
            return last
        }
        else {
            return self[index]
        }
    }
}
