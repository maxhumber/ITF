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
    let service = EverythingService()
    let result = service.always42()
    print(result)
    assert(result == 42)
}

// First XCTestCase
run(false) {
    class EverythingServiceTests: XCTestCase {
        func testAlways42() {
            let service = EverythingService()
            let result = service.always42()
            let expected = 42
            XCTAssert(result == expected) // 🚩 Red Flag!
        }
    }
    
    EverythingServiceTests.defaultTestSuite.run()
}

// XCTestCase with "throws" + "async"
run(false) {
    class EverythingServiceTests: XCTestCase {
        func testAlways42() {
            let service = EverythingService()
            let result = service.always42()
            let expected = 42
            XCTAssert(result == expected)
        }
        
        func testUnlessEmoji42Throws() throws {
            let service = EverythingService()
            let result = try service.unlessEmoji42("X")
            let expected = 42
            XCTAssert(result == expected)
        }
        
        func testEventually42() async {
            let service = EverythingService()
            let result = await service.eventually42()
            let expected = 42
            XCTAssert(result == expected)
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
            print("📫 - before EACH test")
            self.service = EverythingService()
            self.expected = 42
        }
        override func tearDownWithError() throws {
            print("📭 - after EACH test")
        }
        
        func testAlways42() {
            print("1️⃣")
            let result = service.always42()
            XCTAssert(result == expected)
        }
        
        func testUnlessEmoji42Throws() throws {
            print("2️⃣")
            let result = try service.unlessEmoji42("X")
            XCTAssert(result == expected)
        }
        
        func testEventually42() async {
            print("3️⃣")
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
    }
    
    CommonAssertsTests.defaultTestSuite.run()
}

// Throwing Asserts
run(false) {
    class ThrowingAssertsTests: XCTestCase {
        func testThrowingAsserts() throws {
            XCTAssertThrowsError(try ThirdPartyAPI.canAndWillThrow())
            XCTAssertNoThrow(try ThirdPartyAPI.canButWontThrow())
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
            self.service = BeerBeeService()
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
            if number % 3 == 0 && number % 5 == 0 {
                return "🍺🐝"
            } else if number % 3 == 0 {
                return "🍺"
            } else if number % 5 == 0 {
                return "🐝"
            } else {
                return "\(number)"
            }
        }
    }
    
    BeerBeeTests.defaultTestSuite.run()
}

// TDD: Refactor!
class BeerBeeService {
    func beerBee(_ number: Int) -> String {
        let divBy3 = number % 3 == 0
        let divBy5 = number % 5 == 0
        switch (divBy3, divBy5) {
        case (true, true): return "🍺🐝"
        case (true, false): return "🍺"
        case (false, true): return "🐝"
        default: return "\(number)"
        }
    }
}
