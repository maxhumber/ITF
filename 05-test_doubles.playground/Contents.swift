import Foundation
import XCTest

// MARK: - Definitions

// Dummy(s)
// Objects are unrelated to the test and just act as a placeholder.

// Fake(s)
// Objects replicate behaviour and outcomes in a much simpler manner.

// **Stub(s)**
// Objects that always return a set of predefined data (great for networking!)

// Mock(s)
// Objects that remember what's called and knows what do when something is called

// MARK: - Network Stub

@available(iOS 7.0, *)
protocol Networking {
    func data(for request: URLRequest) async throws -> (Data, URLResponse)
}

@available(iOS 7.0, *)
extension URLSession: Networking {
    func data(for request: URLRequest) async throws -> (Data, URLResponse) {
        try await data(for: request, delegate: nil)
    }
}

@available(iOS 7.0, *)
class NetworkStub: Networking {
    private var result: Result<Data, Error>
    
    init(_ result: Result<Data, Error>) {
        self.result = result
    }
    
    func data(for request: URLRequest) async throws -> (Data, URLResponse) {
        try (result.get(), URLResponse())
    }
}

@available(iOS 7.0, *)
class ShowService {
    private let host = "www.episodate.com"
    private let networking: Networking
    
    init(networking: Networking = URLSession.shared) {
        self.networking = networking
    }
    
    private let decoder: JSONDecoder = {
        let decoder = JSONDecoder()
        decoder.dateDecodingStrategy = .formatted(DateFormatter.yyyyMMdd)
        return decoder
    }()
    
    func popular(_ page: Int) async throws -> [TVShow] {
        let request = try endpoint("/api/most-popular", items: ["page": "\(page)"])
        let (data, _) = try await networking.data(for: request)
        let result = try decoder.decode(EpisodateResult.self, from: data)
        return result.shows
    }
    
    private func endpoint(_ path: String, items: [URLQueryItem]) throws -> URLRequest {
        var components = URLComponents()
        components.scheme = "https"
        components.host = host
        components.path = path
        components.queryItems = items
        guard let url = components.url else { throw URLError(.badURL) }
        let request = URLRequest(url: url)
        return request
    }
}

// REPL it!
run(false) {
    let networking = NetworkStub(.failure(URLError(.badServerResponse)))
    let service = ShowService(networking: networking)
    Task {
        do {
            let result = try await service.popular(1)
        } catch {
            print(error.localizedDescription)
        }
    }
}

// Actually wrap it in some tests
run(false) {
    class TVServiceTests: XCTestCase {
        func testBadServerResponse() async {
            let networking = NetworkStub(.failure(URLError(.badServerResponse)))
            let service = ShowService(networking: networking)
            do {
                _ = try await service.popular(1)
                XCTFail("Expected to throw while awaiting, but succeeded")
            } catch {
                let error = error as! URLError
                XCTAssertEqual(error.code, .badServerResponse)
            }
        }
        
        func testGoodServerResponse() async throws {
            let shows = [
                TVShow(name: "Seinfeld", status: "Ended"),
                TVShow(name: "Rick and Morty", status: "Scheduled"),
                TVShow(name: "White Lotus", status: "Schedule")
            ]
            let episodateResult = EpisodateResult(shows: shows)
            let data = try JSONEncoder().encode(episodateResult)
            let networking = NetworkStub(.success(data))
            let service = ShowService(networking: networking)
            let result = try await service.popular(1)
            XCTAssertEqual(shows, result)
        }
    }
    
    TVServiceTests.defaultTestSuite.run()
}

// Another way...
protocol ShowServicing {
    func popular(_ page: Int) async throws -> [TVShow]
}

run(true) {
    class ShowService: ShowServicing {
        private let host = "www.episodate.com"
        private let networking: Networking
        
        init(networking: Networking = URLSession.shared) {
            self.networking = networking
        }
        
        private let decoder: JSONDecoder = {
            let decoder = JSONDecoder()
            decoder.dateDecodingStrategy = .formatted(DateFormatter.yyyyMMdd)
            return decoder
        }()
        
        public func popular(_ page: Int) async throws -> [TVShow] {
            let request = try endpoint("/api/most-popular", items: ["page": "\(page)"])
            let (data, _) = try await networking.data(for: request)
            let result = try decoder.decode(EpisodateResult.self, from: data)
            return result.shows
        }
        
        private func endpoint(_ path: String, items: [URLQueryItem]) throws -> URLRequest {
            var components = URLComponents()
            components.scheme = "https"
            components.host = host
            components.path = path
            components.queryItems = items
            guard let url = components.url else { throw URLError(.badURL) }
            let request = URLRequest(url: url)
            return request
        }
    }
    
    class ShowServiceDouble: ShowServicing {
        public func popular(_ page: Int) async throws -> [TVShow] {[
            TVShow(name: "Seinfeld", status: "Ended"),
            TVShow(name: "Rick and Morty", status: "Scheduled"),
            TVShow(name: "White Lotus", status: "Schedule")
        ]}
    }
    
    let service: ShowServicing = ShowServiceDouble()
    Task {
        _ = try await service.popular(1)
    }
}
