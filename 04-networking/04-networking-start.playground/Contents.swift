import Foundation

// MARK: - Parsing JSON

// Where we left off...
run(false) {
    class ShowService {
        private let host = "www.episodate.com"
        private let networking: URLSession = .shared
        
        public func popular(_ page: Int) async throws {
            let request = try endpoint("/api/most-popular", items: ["page": "\(page)"])
            let (data, _) = try await networking.data(for: request)
            print(data.stringify())
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
    
    // ...
}

// Codable Protocol
run(false) {
    struct EpisodateResult {
        var total: String?
        var page: Int?
        var pages: Int?
    }
    
    class ShowService {
        private let host = "www.episodate.com"
        private let networking: URLSession = .shared
        
        public func popular(_ page: Int) async throws {
            let request = try endpoint("/api/most-popular", items: ["page": "\(page)"])
            let (data, _) = try await networking.data(for: request)
            // ..
            // ..
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
    
    let service = ShowService()
    Task {
        try await service.popular(1)
    }
}

// Dates are always tricky! That's why REPL-ing it is advantageous
extension DateFormatter {
    static let yyyyMMdd: DateFormatter = {
        let formatter = DateFormatter()
        formatter.dateFormat = "yyyy-MM-dd"
        formatter.calendar = Calendar(identifier: .iso8601)
        formatter.locale = Locale(identifier: "en_US_POSIX")
        return formatter
    }()
}

// TVShow + Dates + Coding Keys
run(false) {
    // ...
    // ...
    
    struct TVShow {
        public var name: String
    }

    class ShowService {
        private let host = "www.episodate.com"
        private let networking: URLSession = .shared
        
        private let decoder: JSONDecoder = {
            let decoder = JSONDecoder()
            decoder.dateDecodingStrategy = .formatted(DateFormatter.yyyyMMdd)
            return decoder
        }()
        
        public func popular(_ page: Int) async throws -> [TVShow] {
            let request = try endpoint("/api/most-popular", items: ["page": "\(page)"])
            let (data, _) = try await networking.data(for: request)
            // ...
            // ...
            return [TVShow(name: "Blank")]
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
    
    let service = ShowService()
    Task {
        let shows = try await service.popular(1)
        print(shows)
    }
}
