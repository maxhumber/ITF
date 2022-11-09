import Foundation

@available(iOS 7.0, *)
public protocol Networking {
    func data(for request: URLRequest) async throws -> (Data, URLResponse)
}

@available(iOS 7.0, *)
extension URLSession: Networking {
    public func data(for request: URLRequest) async throws -> (Data, URLResponse) {
        try await data(for: request, delegate: nil)
    }
}

@available(iOS 7.0, *)
public class NetworkingMock: Networking {
    private var result: Result<Data, Error>
    
    public init(_ result: Result<Data, Error>) {
        self.result = result
    }
    
    public func data(for request: URLRequest) async throws -> (Data, URLResponse) {
        try (result.get(), URLResponse())
    }
}

@available(iOS 7.0, *)
public class ShowService {
    private let host = "www.episodate.com"
    private let networking: Networking
    
    public init(networking: Networking = URLSession.shared) {
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

let networking = NetworkingMock(.failure(URLError(.badServerResponse)))
let service = ShowService(networking: networking)

Task {
    do {
        let result = try await service.popular(1)
    } catch {
        print(error.localizedDescription)
    }
}

