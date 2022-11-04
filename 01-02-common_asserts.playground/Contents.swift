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



final class FizzBuzzService {
    
    
    func testFizzBuzzDivisibleBy3ReturnsFizz() { }
    func testFizzBuzzDivisibleBy5ReturnsBuzz() { }
    func testFizzBuzzDivisibleBy15ReturnsFizzBuzz() { }
    func testFizzBuzzNotDivisibleBy3Or5ReturnsInput() { }
    
    //    func fizzBuzz(_ int: Int) -> String {
    //        return ""
    //    }
    
    //    func fizzBuzz(_ number: Int) -> String {
    //        if number % 3 == 0 {
    //            return "Fizz"
    //        } else {
    //            return "\(number)"
    //        }
    //    }
    
    //    func fizzBuzz(_ number: Int) -> String {
    //        if number % 3 == 0 {
    //            return "Fizz"
    //        } else if number % 5 == 0 {
    //            return "Buzz"
    //        } else {
    //            return "\(number)"
    //        }
    //    }
    
    func fizzBuzz(_ number: Int) -> String {
        if number % 3 == 0 {
            return "Fizz"
        } else if number % 5 == 0 {
            return "Buzz"
        } else if number % 3 == 0 && number % 5 == 0 {
            return "\(number)"
        } else {
            return "\(number)"
        }
    }
}

final class FizzBuzzTests: XCTestCase {
    func testDivisibleBy3IsFizz() throws {
        let service = FizzBuzzService()
        let result = service.fizzBuzz(3)
        let expected = "Fizz"
        XCTAssertEqual(result, expected)
    }
    
    func testDivisibleBy5IsBuzz() throws {
        let service = FizzBuzzService()
        let numbers = [5, 10, 20]
        let result = numbers
            .map { service.fizzBuzz($0) }
            .allSatisfy { $0 == "Buzz" }
        //        XCTAssertTrue(result)
        XCTAssert(result)
    }
}

FizzBuzzTests.defaultTestSuite.run()
