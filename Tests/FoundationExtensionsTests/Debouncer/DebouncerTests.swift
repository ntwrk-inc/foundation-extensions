@testable import FoundationExtensions
import XCTest

final class DebouncerTests: XCTestCase {
    // MARK: Internal

    func testThatDebouncerExecuteClosure() {
        let delay: TimeInterval = 2.0
        let startTime = CFAbsoluteTimeGetCurrent()

        let expectation = XCTestExpectation(description: "Run delayed closure")

        debouncer.run(delay: delay) {
            let timeElapsed = CFAbsoluteTimeGetCurrent() - startTime
            XCTAssertEqual(timeElapsed, delay, accuracy: 0.1)

            expectation.fulfill()
        }

        wait(for: [expectation], timeout: 3.0)
    }

    func testThatDebouncerCancelExecutedClosure() {
        let delay: TimeInterval = 0.0

        debouncer.run(delay: delay) {
            XCTFail("The closure must not be executed")
        }

        debouncer.cancel()

        XCTAssertFalse(debouncer.isRunning)
    }

    // MARK: Private

    private let debouncer: Debouncable = Debouncer()
}
