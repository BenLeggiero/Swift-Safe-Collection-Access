import XCTest

import SafeCollectionAccessTests

var tests = [XCTestCaseEntry]()
tests += SafeCollectionAccessTests.allTests
tests += RangeOrNilTests.allTests
XCTMain(tests)
