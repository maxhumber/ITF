import Foundation
import XCTest

extension String: Error {}

enum MyNamespace {
    static func canAndWillThrow() throws {
        throw "Error!"
    }
    
    static func canButWontThrow() throws -> Int {
        return 42
    }
}

final class CommonAssertsTests: XCTestCase {
    func testBoolAsserts() {
        XCTAssertTrue(true)
        XCTAssertFalse(false)
    }
    
    func testNilAsserts() throws {
        XCTAssertNil(nil)
        XCTAssertNotNil("Definitely not nil")
        let number: Int? = 42
        let result = try XCTUnwrap(number)
        let expected = 42
        XCTAssertEqual(result, expected)
    }
    
    func testComparableAsserts() {
        XCTAssertLessThan(42, 43)
        XCTAssertGreaterThan(42, 41)
        XCTAssertLessThanOrEqual(42, 42)
        XCTAssertGreaterThanOrEqual(42, 42)
    }
    
    func testThrowingAsserts() throws {
        XCTAssertThrowsError(try MyNamespace.canAndWillThrow())
        XCTAssertNoThrow(try MyNamespace.canButWontThrow())
    }
}

CommonAssertsTests.defaultTestSuite.run()
