import XCTest
@testable import OsuParsing

final class OsuParsingTests: XCTestCase {
    func testExample() {
        // This is an example of a functional test case.
        // Use XCTAssert and related functions to verify your tests produce the correct
        // results.
        XCTAssertEqual(OsuParsing().text, "Hello, World!")
    }

    static var allTests = [
        ("testExample", testExample),
    ]
}
