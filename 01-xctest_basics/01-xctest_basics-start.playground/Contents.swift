import Foundation
import XCTest

// MARK: - XCTestCase + Life Cycle Basics

// A simple service inspired by Douglas Adams 😜
class EverythingService {
    func always42() -> Int {
        return 42
    }
    
    func unlessEmoji42(_ str: String) throws -> Int {
        if str.containsEmoji { throw "Bad Input!" }
        return 42
    }
    
    func eventually42() async -> Int {
        try? await Task.sleep(nanoseconds: 2 * 1_000_000)
        return 42
    }
}

// Run service as though it were in a VC/VM...
run(false) {

}

// First XCTestCase
run(false) {
    class EverythingServiceTests: XCTestCase {
        func testAlways42() {
            
        }
    }
    
    EverythingServiceTests.defaultTestSuite.run()
}

// XCTestCase with "throws" + "async"
run(false) {
    class EverythingServiceTests: XCTestCase {
        func testAlways42() {
            
        }
        
        func testUnlessEmoji42Throws() throws {
            
        }
        
        func testEventually42() async {
            
        }
    }
    
    EverythingServiceTests.defaultTestSuite.run()
}

// XCTestCase with setUp + tearDown
run(false) {
    class EverythingServiceTests: XCTestCase {
        var service: EverythingService!
        var expected: Int!
        
        override func setUpWithError() throws {
            
        }
        
        override func tearDownWithError() throws {
            
        }
        
        func testAlways42() {
            let result = service.always42()
            XCTAssert(result == expected)
        }
        
        func testUnlessEmoji42Throws() throws {
            let result = try service.unlessEmoji42("X")
            XCTAssert(result == expected)
        }
        
        func testEventually42() async {
            let result = await service.eventually42()
            XCTAssert(result == expected)
        }
    }
    
    EverythingServiceTests.defaultTestSuite.run()
}

// MARK: - Common Asserts

// true, false, nil, == and more!
run(false) {
    class CommonAssertsTests: XCTestCase {
        func testBoolAsserts() {

        }
        
        func testNilAsserts() throws {

        }
        
        func testComparableAsserts() {

        }
    }
    
    CommonAssertsTests.defaultTestSuite.run()
}

// Throwing Asserts
run(false) {
    class ThrowingAssertsTests: XCTestCase {
        func testThrowingAsserts() throws {

        }
    }
    
    ThrowingAssertsTests.defaultTestSuite.run()
}

// MARK: - TDD

// Setup: totally not FizzBuzz!
run(false) {
    class BeerBeeTests: XCTestCase {
        var service: BeerBeeService!
        
        override func setUp() {
            
        }
        
        func testDisivibleBy3And5IsBeerBee() {}
        
        func testDivisibleBy3IsBeer() {}
        
        func testDivisibleBy5IsBee() {}
        
        func testNotSpecial() {}
    }
    
    class BeerBeeService {
        func beerBee(_ number: Int) -> String {
            return "\(number)"
        }
    }
    
    BeerBeeTests.defaultTestSuite.run()
}

// TDD: AAA + RED
run(false) {
    class BeerBeeTests: XCTestCase {
        var service: BeerBeeService!
        
        override func setUp() {
            // 1. Arrange

        }
        
        func testDisivibleBy3And5IsBeerBee() {
            // 2. Act
            // 3. Assert
        }
        
        func testDivisibleBy3IsBeer() {
            
        }
        
        func testDivisibleBy5IsBee() {

        }
        
        func testNotSpecial() {

        }
    }
    
    class BeerBeeService {
        func beerBee(_ number: Int) -> String {
            return "\(number)"
        }
    }
    
    BeerBeeTests.defaultTestSuite.run()
}

// TDD: Get it to GREEN
run(false) {
    class BeerBeeTests: XCTestCase {
        var service: BeerBeeService!
        
        override func setUp() {
            // 1. Arrange
            self.service = BeerBeeService()
        }
        
        func testDisivibleBy3And5IsBeerBee() {
            // 2. Act
            let result = service.beerBee(15)
            // 3. Assert
            let expected = "🍺🐝"
            XCTAssertEqual(result, expected)
        }
        
        func testDivisibleBy3IsBeer() {
            let result = service.beerBee(3)
            let expected = "🍺"
            XCTAssertEqual(result, expected)
        }
        
        func testDivisibleBy5IsBee() {
            let numbers = [5, 10, 20]
            let result = numbers
                .map { service.beerBee($0) }
                .allSatisfy { $0 == "🐝" }
            XCTAssertTrue(result)
        }
        
        func testNotSpecial() {
            let result = service.beerBee(4)
            let expected = "4"
            XCTAssertEqual(result, expected)
        }
    }
    
    class BeerBeeService {
        func beerBee(_ number: Int) -> String {
            ""
        }
    }
    
    BeerBeeTests.defaultTestSuite.run()
}

// TDD: Refactor!
class BeerBeeService {
    func beerBee(_ number: Int) -> String {
        ""
    }
}
