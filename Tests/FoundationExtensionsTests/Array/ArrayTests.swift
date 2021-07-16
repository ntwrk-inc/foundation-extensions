@testable import FoundationExtensions
import XCTest

final class ArrayTests: XCTestCase {
    func testThatGettingElementByIndexIsSafe() {
        let array = [1, 2, 3]
        XCTAssertNil(array[safe: 5], "Element at index 5 should be nil")
        XCTAssertEqual(array[safe: 1], 2, "Elements should have the same values")
    }
}
