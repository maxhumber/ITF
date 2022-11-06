import Foundation
import XCTest

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

class EverythingServiceAndLifeCycleExampleTests: XCTestCase {
    override class func setUp() {
        print("🎬 - before ALL tests")
    }
    
    override func setUpWithError() throws {
        print("📫 - before EACH test")
    }
    override func tearDownWithError() throws {
        print("📭 - after EACH test")
    }
    
    override class func tearDown() {
        print("🏁 - after ALL tests")
    }
    
    func testAlways42() {
        print("1️⃣")
        let service = EverythingService()
        let result = service.always42()
        let expected = 42
        XCTAssert(result == expected) // 🚩 Red Flag!
    }
    
    func testUnlessEmoji42Throws() throws {
        print("2️⃣")
        let service = EverythingService()
//        let result = try service.unlessEmoji42("🌌")
        let result = try service.unlessEmoji42("X")
        let expected = 42
        XCTAssert(result == expected) // 🚩 Red Flag!
    }
    
    func testEventually42() async {
        print("3️⃣")
        let service = EverythingService()
        let result = await service.eventually42()
        let expected = 42
        XCTAssert(result == expected) // 🚩 Red Flag!
    }
}

EverythingServiceAndLifeCycleExampleTests.defaultTestSuite.run()

