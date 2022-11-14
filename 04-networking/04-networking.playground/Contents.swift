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
    
    let service = ShowService()
    Task {
        try await service.popular(1)
    }
}

// Codable Protocol
run(false) {
    struct EpisodateResult: Codable {
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
            let result = try JSONDecoder().decode(EpisodateResult.self, from: data)
            print(result)
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
    struct EpisodateResult: Codable {
        var total: String?
        var page: Int?
        var pages: Int?
        var shows: [TVShow]
        
        private enum CodingKeys: String, CodingKey {
            case shows = "tv_shows"
            case page
            case pages
            case total
        }
    }
    
    struct TVShow: Codable {
        public var name: String
        public var network: String?
        public var status: String
        public var startDate: Date
        public var endDate: Date?
        public var thumbnail: URL
        
        private enum CodingKeys: String, CodingKey {
            case name
            case network
            case status
            case startDate = "start_date"
            case endDate = "end_date"
            case thumbnail = "image_thumbnail_path"
        }
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
    
    let service = ShowService()
    Task {
        let shows = try await service.popular(1)
        print(shows)
    }
}
