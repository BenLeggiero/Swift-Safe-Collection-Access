import XCTest

#if !canImport(ObjectiveC)
public func allTests() -> [XCTestCaseEntry] {
    return [
        testCase(SafeCollectionAccessTests.allTests),
        testCase(RangeOrNilTests.allTests),
    ]
}
#endif
