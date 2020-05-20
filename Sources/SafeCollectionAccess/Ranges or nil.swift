//
//  Ranges or nil.swift
//  Safe Collection Access
//
//  Created by Ben Leggiero on 2020-05-20.
//  Copyright © 2020 Ben Leggiero BH-1-PS.
//

import Foundation



public extension RandomAccessCollection
    where Index: Strideable,
        Index.Stride: SignedInteger 
{
    /// Safely access ranges in this collection.
    /// If the range you pass extends outside this collection, `nil` is returned.
    ///
    /// - Complexity: O(n)
    ///
    /// - Parameter range: A range of valid lower and upper indices of characters in the string.
    /// - Returns: The characters at the given index-range in this string, or `nil` if the given range is not contained
    ///            within `0` (inclusive) and `count` (exclusive).
    @inlinable
    subscript(orNil range: ClosedRange<Index>) -> SubSequence? {
        return contains(allIn: range)
            ? self[range]
            : nil
    }
    
    
    /// Safely access ranges in this collection.
    /// If the range you pass extends outside this collection, `nil` is returned.
    ///
    /// - Complexity: O(n)
    ///
    /// - Parameter range: A range of valid lower and upper indices of characters in the string.
    /// - Returns: The characters at the given index-range in this string, or `nil` if the given range is not contained
    ///            within `0` (inclusive) and `count` (inclusive).
    @inlinable
    subscript(orNil range: Range<Index>) -> SubSequence? {
        return contains(allIn: range)
            ? self[range]
            : nil
    }
    
    
    /// Safely access ranges in this collection.
    /// If the range you pass extends outside this collection, `nil` is returned.
    ///
    /// - Complexity: O(1)
    ///
    /// - Parameter range: A range of a valid lower index of characters in the string.
    /// - Returns: The characters at the given index-range in this string, or `nil` if the given range is not contained
    ///            within `0` (inclusive) and `count` (exclusive).
    @inlinable
    subscript(orNil range: PartialRangeFrom<Index>) -> SubSequence? {
        return contains(index: range.lowerBound)
            ? self[orNil: Range(uncheckedBounds: (lower: range.lowerBound, upper: endIndex))]
            : nil
    }
    
    
    /// Safely access ranges in this collection.
    /// If the range you pass extends outside this collection, `nil` is returned.
    ///
    /// - Complexity: O(1)
    ///
    /// - Parameter range: A range of a valid upper index of characters in the string.
    /// - Returns: The characters at the given index-range in this string, or `nil` if the given range's bound is not
    ///            within `0` (inclusive) and `count` (inclusive).
    @inlinable
    subscript(orNil range: PartialRangeUpTo<Index>) -> SubSequence? {
        return contains(index: index(before: range.upperBound))
            ? self[orNil: startIndex ..< range.upperBound]
            : nil
    }
    
    
    /// Safely access ranges in this collection.
    /// If the range you pass extends outside this collection, `nil` is returned.
    ///
    /// - Complexity: O(1)
    ///
    /// - Parameter range: A range of a valid upper index of characters in the string.
    /// - Returns: The characters at the given index-range in this string, or `nil` if the given range's bound is not
    ///            within `0` (inclusive) and `count` (exclusive).
    @inlinable
    subscript(orNil range: PartialRangeThrough<Index>) -> SubSequence? {
        return contains(index: range.upperBound)
            ? self[orNil: startIndex ... range.upperBound]
            : nil
    }
}
