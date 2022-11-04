import Foundation
import XCTest

final class BeerBeeService {
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
//    func testDivisibleBy3ReturnsBeer() { }
//    func testDivisibleBy5ReturnsBee() { }
//    func testFizzBuzzDivisibleBy15ReturnsBeerBee() { }
//    func testFizzBuzzNotDivisibleBy3Or5ReturnsInput() { }
    
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
