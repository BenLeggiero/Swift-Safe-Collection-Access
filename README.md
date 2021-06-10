[![Tested on GitHub Actions](https://github.com/RougeWare/Swift-Safe-Collection-Access/actions/workflows/swift.yml/badge.svg)](https://github.com/RougeWare/Swift-Safe-Collection-Access/actions/workflows/swift.yml) [![](https://www.codefactor.io/repository/github/rougeware/swift-safe-collection-access/badge)](https://www.codefactor.io/repository/github/rougeware/swift-safe-collection-access)

[![Swift 5](https://img.shields.io/badge/swift-5-brightgreen.svg?logo=swift&logoColor=white)](https://swift.org) [![swift package manager 5.2 is supported](https://img.shields.io/badge/swift%20package%20manager-5.2-brightgreen.svg)](https://swift.org/package-manager) [![Supports macOS, iOS, tvOS, watchOS, Linux, & Windows](https://img.shields.io/badge/macOS%20%7C%20iOS%20%7C%20tvOS%20%7C%20watchOS%20%7C%20Linux%20%7C%20Windows-grey.svg)](./Package.swift) 
[![](https://img.shields.io/github/release-date/rougeware/swift-safe-collection-access?label=latest%20release)](https://github.com/RougeWare/Swift-Safe-Collection-Access/releases/latest)


# Swift Safe Collection Access #

Ever wonder why Swift crashes if you access a collection the wrong way? Especially an array? Me too here's some extensions. 🎉



## `collection[orNil:]` ##

This subscript fails gracefully on invalid input by returning `nil` or refusing to mutate the collection. With valid input, it behaves precisely like Swift's builtin subscripts!

```swift

import SafeCollectionAccess



var first5Fibonacci = [1, 1, 2, 3, 5]

first5Fibonacci[orNil: 0]                       // Optional(1)
first5Fibonacci[orNil: 3] == first5Fibonacci[3] // true
first5Fibonacci[orNil: 999]                     // `nil`
first5Fibonacci[orNil: -1]                      // `nil`

first5Fibonacci[orNil: 2...4]  // Optional([2, 4])
first5Fibonacci[orNil: -2...2] // `nil`
first5Fibonacci[orNil: ..<42]  // `nil`


first5Fibonacci[orNil: 1]   = 42  // [1, 42, 2, 3, 5]
first5Fibonacci[orNil: 999] = -1  // [1, 42, 2, 3, 5]
first5Fibonacci[orNil: -1]  = 777 // [1, 42, 2, 3, 5]

first5Fibonacci[orNil: 0...2]  = [9, 5]    // [9, 5, 3, 5]
first5Fibonacci[orNil: -2...2] = [42]      // [9, 5, 3, 5]
first5Fibonacci[orNil: ..<42]  = [7, 7, 7] // [9, 5, 3, 5]
```



## `collection[clamping:]` ##

This subscript fails gracefully on invalid input by returning or mutating the closest valid element (or, with empty collections, returning `nil` or refusing to mutate). With valid input, it behaves precisely like Swift's builtin subscripts!

```swift

import SafeCollectionAccess



var first5Fibonacci = [1, 1, 2, 3, 5]

first5Fibonacci[clamping: 0]                       // 1
first5Fibonacci[clamping: 3] == first5Fibonacci[3] // true
first5Fibonacci[clamping: 999]                     // 5
first5Fibonacci[clamping: -1]                      // 1


first5Fibonacci[clamping: 1]   = 42  // [1, 42, 2, 3, 5]
first5Fibonacci[clamping: 999] = -1  // [1, 42, 2, 3, -1]
first5Fibonacci[clamping: -1]  = 777 // [777, 42, 2, 3, -1]
```
