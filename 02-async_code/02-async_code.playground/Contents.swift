import Foundation
import XCTest

// Attempt to use the "Third Party API"
run(false) {
    EpisodateAPI.popular(1) { response in
        switch response {
        case .success(let data):
            print(data)
        case .failure(let error):
            print(error.localizedDescription)
        }
    }
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
    EpisodateAPI.popular(1) { response in
        switch response {
        case .success(let data):
            print(data.stringify())
        case .failure(let error):
            print(error.localizedDescription)
        }
    }
}

// Simulated TVService using the "Third Party API"
class TVService {
    var json: String = "" // 🚩 Should, and will, decode...
    var error: Error? = nil
    
    func fetch(_ page: CustomStringConvertible) {
        EpisodateAPI.popular(page) { response in
            switch response {
            case .success(let data):
                self.json = data.stringify()
            case .failure(let error):
                self.error = error
            }
        }
    }
}

// Convert completion code into new async/await
class NewTVService {
    func fetch(_ page: CustomStringConvertible) async throws -> String {
        try await withCheckedThrowingContinuation { continutation in
            EpisodateAPI.popular(page) { response in
                switch response {
                case .success(let data):
                    continutation.resume(returning: data.stringify())
                case .failure(let error):
                    continutation.resume(throwing: error)
                }
            }
        }
    }
}

// REPL test the "NewTVService"
run(false) {
    Task {
        let service = NewTVService()
        let result = try await service.fetch(1)
        print(result)
    }
}

// Simple XCTestCase
run(false) {
    class TVServiceTests: XCTestCase {
        func testFetch() async throws {
            let service = NewTVService()
            let result = try await service.fetch(1)
            let containsTheFlash = result.contains("The Flash")
            XCTAssert(containsTheFlash)
        }
        
        func moreTestsToCome() {
            // Don't worrry!!
        }
    }
    
    TVServiceTests.defaultTestSuite.run()
}
