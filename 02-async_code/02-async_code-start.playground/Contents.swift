import Foundation
import XCTest

// Attempt to use the "Third Party API"
run(false) {

}

// REPL Network Helper
extension Data {
    public func stringify() -> String {
        do {
            let json = try JSONSerialization.jsonObject(with: self, options: [])
            let data = try JSONSerialization.data(withJSONObject: json, options: .prettyPrinted)
            guard let string = String(data: data, encoding: .utf8) else { fatalError() }
            let pastableString = string
                .replacingOccurrences(of: #"\/"#, with: "/", options: .literal, range: nil)
                .replacingOccurrences(of: "\" : ", with: "\": ", options: .literal, range: nil)
            return pastableString
        } catch {
            fatalError()
        }
    }
}

// Stringify the response with Data+stringify()
run(false) {

}

// Simulated TVService using the "Third Party API"
class TVService {
    var json: String = "" // 🚩 Should, and will, decode...
    var error: Error? = nil
    
    func fetch(_ page: CustomStringConvertible) {

    }
}

// Convert completion code into new async/await
class NewTVService {
    func fetch(_ page: CustomStringConvertible) async throws -> String {
        ""
    }
}

// REPL test the "NewTVService"
run(false) {
    Task {

    }
}

// Simple XCTestCase
run(false) {
    class TVServiceTests: XCTestCase {
        func testFetch() async throws {

        }
        
        func moreTestsToCome() {
            // Don't worrry!!
        }
    }
    
    TVServiceTests.defaultTestSuite.run()
}
