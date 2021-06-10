//
//  Ranges or nil.swift
//  Safe Collection Access
//
//  Created by Ben Leggiero on 2020-05-20.
//  Copyright © 2020 Ben Leggiero BH-1-PS.
//

import Foundation



public extension RandomAccessCollection {
    
    /// Determines whether this collection contains elements throughout the given range
    ///
    /// - Parameter range: The range of elements to test
    /// - Returns: `true` iff this collection contains elements at all the indices covered by the `range`
    func completelyContains<RangeType>(range: RangeType) -> Bool
    where RangeType: SafeRangeExpression,
          RangeType.Bound == Index
    {
        guard let range = range.relative(clampingIfContainedWithin: self) else {
            return false
        }
        
        return completelyContains(range: range)
    }
    
    
    /// Determines whether this collection contains elements throughout the given range
    ///
    /// - Parameter range: The range of elements to test
    /// - Returns: `true` iff this collection contains elements at all the indices covered by the `range`
    func completelyContains(range: Range<Index>) -> Bool {
        contains(index: range.lowerBound)
            && contains(index: index(before: range.upperBound))
    }
    
    
    /// Determines whether this collection contains any elements at the given range, even if the range extends beyond this collection
    ///
    /// - Parameter range: The range of elements to test
    /// - Returns: `true` iff this collection contains elements at any of the indices covered by the `range`
    func rangeOverlapsThisCollection<RangeType>(_ range: RangeType) -> Bool
    where RangeType: SafeRangeExpression,
          RangeType.Bound == Index
    {
        guard let range = range.relative(clampingIfContainedWithin: self) else {
            return false
        }
        
        return rangeOverlapsThisCollection(range)
    }
    
    
    /// Determines whether this collection contains any elements at the given range, even if the range extends beyond this collection
    ///
    /// - Parameter range: The range of elements to test
    /// - Returns: `true` iff this collection contains elements at any of the indices covered by the `range`
    func rangeOverlapsThisCollection(_ range: Range<Index>) -> Bool {
        contains(index: range.lowerBound)
            || contains(index: index(before: range.upperBound))
    }
    
    
    /// Some sugar for clamping the given range within this collection. If the given range doesn't overlap this collection at all, `nil` is returned.
    ///
    /// This sugar sweetens `SafeRangeExpression`'s `relative(clampingTo:)` method.
    ///
    /// - Parameter range: The range to clamp to this collection
    /// - Returns: A range which is definitely within this collecion, or `nil` if it doesn't overlap this collection
    @inline(__always)
    func clamp<RangeType>(range: RangeType) -> Range<Index>?
    where RangeType: SafeRangeExpression,
          RangeType.Bound == Index
    {
        range.relative(clampingIfContainedWithin: self)
    }
    
    
    /// A generic implementation of the below `[orNil:]` subscripts
    @inline(__always)
    @usableFromInline
    internal subscript<RangeType>(_orNil_getOnly range: RangeType) -> SubSequence?
    where RangeType: SafeRangeExpression,
          RangeType.Bound == Index
    {
       clamp(range: range).map { self[$0] }
    }
    
    
    /// Safely access ranges in this collection.
    /// If the range you pass extends outside this collection, `nil` is returned.
    ///
    /// - Complexity: O(1)
    ///
    /// - Parameter range: A range of valid indices of characters in the collection.
    /// - Returns: The characters at the given index-range in this string, or `nil` if the given range is not contained
    ///            within `0` (inclusive) and `count` (exclusive).
    @inlinable
    subscript<RangeType>(orNil range: RangeType) -> SubSequence?
    where RangeType: SafeRangeExpression,
          RangeType.Bound == Index {
        self[_orNil_getOnly: range]
    }
    
    
    /// Safely access or mutate ranges in this collection.
    /// If the range you pass extends outside this collection, `nil` is returned, or if you're trying to mutate this collection, nothing is done.
    /// Setting the value to `nil` is interpreted as removing the range from this collection
    ///
    /// - Complexity: O(1)
    ///
    /// - Parameter range: A range of valid indices of characters in the collection.
    /// - Returns: The characters at the given index-range in this string, or `nil` if the given range is not contained
    ///            within `0` (inclusive) and `count` (exclusive).
    @inlinable
    subscript<RangeType>(orNil range: RangeType) -> SubSequence?
    where RangeType: SafeRangeExpression,
          RangeType.Bound == Index,
          Self: MutableCollection,
          Self: RangeReplaceableCollection
    {
        get { self[_orNil_getOnly: range] }
        
        set {
            guard rangeOverlapsThisCollection(range) else { return }
            
            if let newValue = newValue {
                self[range] = newValue
            }
            else {
                self.removeSubrange(range)
            }
        }
    }
}
