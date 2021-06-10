//
//  SafeRangeExpression.swift
//  
//
//  Created by Ben Leggiero on 2021-06-08.
//

import Foundation
import RangeTools



public protocol SafeRangeExpression: RangeExpression {
    
    /// Returns the range of indices described by this range expression within the given collection, guaranteeing it does not overextend the collection's boundaries.
    ///
    /// - Parameter collection: This is used when resolving this range to a `Range`.
    /// - Returns: A range which is safe to use in `collection`. The returned range is guaranteed to be inside the bounds of `collection`
    func relative<RelativeCollection>(clampingIfContainedWithin collection: RelativeCollection) -> Range<Bound>?
    where RelativeCollection: Collection,
          Bound == RelativeCollection.Index
}



// MARK: - Default conformances

// MARK: Upper & lower bounds

extension RangeWithLowerAndUpperBound where Self: SafeRangeExpression {
    
    public func relative<RelativeCollection>(clampingIfContainedWithin collection: RelativeCollection) -> Range<Bound>?
    where RelativeCollection: Collection,
          Bound == RelativeCollection.Index
    {
        relative(clampingIfContainedWithin: collection,
                 guard: { upperBoundIsWithin($0) && lowerBoundIsWithin($0) },
                 clampedLowerBound: clampedLowerBound,
                 clampedUpperBoundExclusive: clampedUpperBoundExclusive)
    }
}



extension Range: SafeRangeExpression {}
extension ClosedRange: SafeRangeExpression {}



// MARK: Just lower bounds

extension RangeWithLowerBound where Self: SafeRangeExpression {
    
    public func relative<RelativeCollection>(clampingIfContainedWithin collection: RelativeCollection) -> Range<Bound>?
    where RelativeCollection: Collection,
          Bound == RelativeCollection.Index
    {
        relative(clampingIfContainedWithin: collection,
                 guard: lowerBoundIsWithin,
                 clampedLowerBound: clampedLowerBound,
                 clampedUpperBoundExclusive: \.endIndex)
        
    }
    
    
    /// Determines whether the upper bound is within the given collection
    fileprivate func lowerBoundIsWithin<RelativeCollection>(_ collection: RelativeCollection) -> Bool
    where RelativeCollection: Collection,
          Bound == RelativeCollection.Index
    {
        bound(lowerBound, isWithin: collection, lookBeyondStartIndex: false, lookBeyondEndIndex: true)
    }
    
    
    /// Returns the upper bound, clamped to be within the collection, exclusively (so that it refers to the item before its index)
    ///
    /// - Parameter collection: The collection to clamp the upper bound to
    /// - Returns: The upper bound, clamped within `collection`
    fileprivate func clampedLowerBound<RelativeCollection>(in collection: RelativeCollection)
    -> Bound
    where RelativeCollection: Collection,
          RelativeCollection.Index == Bound
    {
        Swift.max(collection.startIndex, Swift.min(self.lowerBound, collection.endIndex))
    }
}



extension PartialRangeFrom: SafeRangeExpression {}



// MARK: Just upper bounds

extension RangeWithUpperBound where Self: SafeRangeExpression {
    
    public func relative<RelativeCollection>(clampingIfContainedWithin collection: RelativeCollection) -> Range<Bound>?
    where RelativeCollection: Collection,
          Bound == RelativeCollection.Index
    {
        relative(clampingIfContainedWithin: collection,
                 guard: upperBoundIsWithin,
                 clampedLowerBound: \.startIndex,
                 clampedUpperBoundExclusive: clampedUpperBoundExclusive)
    }
    
    
    /// Determines whether the upper bound is within the given collection
    fileprivate func upperBoundIsWithin<RelativeCollection>(_ collection: RelativeCollection) -> Bool
    where RelativeCollection: Collection,
          Bound == RelativeCollection.Index
    {
        bound(upperBound, isWithin: collection, lookBeyondStartIndex: Self.upperBoundIsInclusive, lookBeyondEndIndex: false) // Ranges with an upper but no lower bound can place their upper bound just before the start index for an empty slice
    }
    
    
    /// Returns the upper bound, clamped to be within the collection, exclusively (so that it refers to the item before its index)
    ///
    /// - Parameter collection: The collection to clamp the upper bound to
    /// - Returns: The upper bound, clamped within `collection`
    fileprivate func clampedUpperBoundExclusive<RelativeCollection>(in collection: RelativeCollection) -> Bound
    where RelativeCollection: Collection,
          RelativeCollection.Index == Bound
    {
        let baseIndex = Swift.min(Swift.max(collection.startIndex, self.upperBound), collection.endIndex)
        
        if Self.upperBoundIsInclusive {
            return collection.index(after: baseIndex)
        }
        else {
            return baseIndex
        }
    }
}



extension PartialRangeUpTo: SafeRangeExpression {}
extension PartialRangeThrough: SafeRangeExpression {}



// MARK: - Private conveniences

private extension SafeRangeExpression where Self: RangeProtocol {
    
    /// Generically find the range clamped relative to the given collection, with custom behavior. This returns `nil` if the range doesn't overlap the collection at all
    ///
    /// - Parameters:
    ///   - collection:                 The collection we're relating this to
    ///   - guard:                      The function which, if `false`, will always result in this returning `nil`
    ///   - clampedLowerBound:          Creates a lower boundary that's clamped within the collection
    ///   - clampedUpperBoundExclusive: Creates a upper boundary that's clamped within the collection, excluding the item at its idnex value
    ///
    /// - Returns: A range clamped within the collection, or `nil` if the range doesn't touch the collection at all
    @inline(__always)
    func relative<RelativeCollection>(
        clampingIfContainedWithin collection: RelativeCollection,
        guard: (_ collection: RelativeCollection) -> Bool,
        clampedLowerBound: (_ collection: RelativeCollection) -> Bound,
        clampedUpperBoundExclusive: (_ collection: RelativeCollection) -> Bound)
    -> Range<Bound>?
    where RelativeCollection: Collection,
          Bound == RelativeCollection.Index
    {
        guard `guard`(collection) else {
            return nil
        }
        
        guard !collection.isEmpty else {
            return collection.startIndex ..< collection.endIndex
        }
        
        return clampedLowerBound(collection) ..< clampedUpperBoundExclusive(collection)
    }
    
    
    /// Determines whether the given bound is within the collection
    ///
    /// - Parameters:
    ///   - bound:      The bound to check
    ///   - collection: The collection to check against
    ///   - lookBeyondStartIndex: If `true`, then `bound` can be up to `1` beyond the collection's start index
    ///   - lookBeyondEndIndex:  if `true`, then `bound` can be up to `1` beyond the collection's end index
    ///
    /// - Returns: `true` iff the given bound is in the given collection
    @inline(__always)
    func bound<RelativeCollection>(_ bound: Bound, isWithin collection: RelativeCollection, lookBeyondStartIndex: Bool, lookBeyondEndIndex: Bool) -> Bool
    where RelativeCollection: Collection,
          Bound == RelativeCollection.Index
    {
        let startIndex = lookBeyondStartIndex ? collection.index(collection.startIndex, offsetBy: -1) : collection.startIndex
        
        guard bound >= startIndex else {
            return false
        }
        
        if !Self.upperBoundIsInclusive
            || lookBeyondEndIndex{
            // If the upper bound is EXclusive, then `endIndex..<endIndex` means "an empty slice from the end"
            return bound <= collection.endIndex
        }
        else {
            // Since we're trying to get the EXclusive upper bound, then if this range is INclusive, return the one after our EXclusive one
            return bound < collection.endIndex
        }
    }
}
