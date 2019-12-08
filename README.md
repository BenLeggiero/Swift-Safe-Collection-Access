# Swift Safe Collection Access #

Ever wonder why Swift crashes if you access a collection the wrong way? Especially an array? Me too here's some extensions.



## Example ##

```swift

import SafeCollectionAccess



let first5Fibonacci = [1, 1, 2, 3, 5]

print(first5Fibonacci[orNil: 0]) // Optional(1)
print(first5Fibonacci[orNil: 0] == first5Fibonacci[safe: 1]) // true
print(first5Fibonacci[safe: 5]) // nil
```
