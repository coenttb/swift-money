import XCTest
@testable import Money

final class MoneyTests: XCTestCase {
    func testExample() {
        // This is an example of a functional test case.
        // Use XCTAssert and related functions to verify your tests produce the correct
        // results.
        XCTAssertEqual(Money().text, "Hello, World!")
    }

    static var allTests = [
        ("testExample", testExample),
    ]
}
