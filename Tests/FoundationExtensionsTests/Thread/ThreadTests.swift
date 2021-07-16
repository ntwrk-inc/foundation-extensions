@testable import FoundationExtensions
import XCTest

final class ThreadTests: XCTestCase {
    func testThatThreadRunningClosureOnMainThread() {
        onMain {
            XCTAssertTrue(Thread.isMainThread, "The closure must be running on the main thread")
        }
    }

    func testThatThreadRunningClosureOnBackgroundThread() {
        onBackground {
            XCTAssertFalse(!Thread.isMainThread, "The closure must be running on the background thread")
            XCTAssertEqual(Thread.current.threadName, backgroundThread.label, "The threads must be equal")
        }
    }
}
