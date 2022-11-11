import Foundation

final class ShowService {
    private let host = "episodate.com"
    private let networking: URLSession
    
    private let decoder: JSONDecoder = {
        let decoder = JSONDecoder()
        decoder.dateDecodingStrategy = .formatted(DateFormatter.yyyyMMdd)
        return decoder
    }()
    
    init(networking: URLSession = .shared) {
        self.networking = networking
    }
    
    func popular(_ page: Int) async throws -> [Show] {
        let queryItems: [URLQueryItem] = ["page": "\(page)"]
        let request = try build("/api/most-popular", queryItems: queryItems)
        let (data, _) = try await networking.data(for: request)
        let result = try decoder.decode(EpisodateResult.self, from: data)
        return result.shows
    }
    
    private func build(_ endpoint: String, queryItems: [URLQueryItem]) throws -> URLRequest {
        var components = URLComponents()
        components.scheme = "https"
        components.host = host
        components.path = endpoint
        components.queryItems = queryItems
        guard let url = components.url else { throw URLError(.badURL) }
        let request = URLRequest(url: url)
        return request
    }
}
