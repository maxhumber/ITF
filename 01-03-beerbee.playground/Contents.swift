import Foundation
import XCTest

final class BeerBeeService {
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

final class BeerBeeTests: XCTestCase {
    var service: BeerBeeService!
    
    override func setUp() {
        self.service = BeerBeeService()
    }
    
    func testDisivibleBy3And5IsBeerBee() {
        let result = service.beerBee(15)
        let expected = "🍺🐝"
        XCTAssertEqual(result, expected)
    }
    
    func testDivisibleBy3IsBeer() {
        // 2. Act
        let result = service.beerBee(3)
        let expected = "🍺"
        // 3. Assert
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

BeerBeeTests.defaultTestSuite.run()
