import Foundation
import XCTest

/// Keep everything neat and tidy!
func block(_ title: String? = nil, silence: Bool = false, code: @escaping () -> Void) {
    if silence { return }
    code()
}

enum EpisodateAPI {
    /// Most Popular TV Shows
    /// A complete list of Most Popular TV Shows. TV Shows are returned in descending order and contain the basic information about them.
    /// URL: /api/most-popular?page=:page
    /// Example: https://www.episodate.com/api/most-popular?page=1
    static func popular(_ page: CustomStringConvertible, completionHandler: @escaping (Result<Data, Error>) -> ()) {
        var components = URLComponents()
        components.scheme = "https"
        components.host = "www.episodate.com"
        components.path = "/api/most-popular"
        components.queryItems = [URLQueryItem(name: "page", value: "\(page)")]
        guard let url = components.url else {
            completionHandler(.failure(URLError(.badURL)))
            return
        }
        var request = URLRequest(url: url)
        let task = URLSession.shared.dataTask(with: request) { data, response, error in
            if let error = error {
                completionHandler(.failure(error))
                return
            }
            guard let data = data, let response = response as? HTTPURLResponse, response.statusCode == 200 else {
                completionHandler(.failure(URLError(.badServerResponse)))
                return
            }
            completionHandler(.success(data))
        }
        task.resume()
    }
}

// Fake out a API...
block("SDK/API Simulation", silence: true) {
    EpisodateAPI.popular(1) { response in
        switch response {
        case .success(let data):
            print(data)
        case .failure(let error):
            print(error.localizedDescription)
        }
    }
}

// Network Data REPL Helper!
extension Data {
    func stringify() -> String {
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

block("Stringify", silence: false) {
    EpisodateAPI.popular(1) { response in
        switch response {
        case .success(let data):
            print(data.stringify())
        case .failure(let error):
            print(error.localizedDescription)
        }
    }
}

class TVService {
    var json: String = "" // 🚩 Should, and will decode...
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

/// withChecked(Throwing)Continuation
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

block("Actually using the new service!", silence: false) {
    Task {
        let service = NewTVService()
        let result = try await service.fetch(1)
        print(result)
    }
}

class TVServiceTests: XCTestCase {
    func testFetchNotNil() async throws {
        let service = NewTVService()
        let result = try await service.fetch(1)
        XCTAssertNotNil(result)
    }
    
    func moreTestsToCome() {
        // Don't worrry!!
    }
}

TVServiceTests.defaultTestSuite.run()
