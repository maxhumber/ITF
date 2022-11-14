import Foundation

public enum EpisodateAPI {
    /// Most Popular TV Shows
    /// A complete list of Most Popular TV Shows. TV Shows are returned in descending order and contain the basic information about them.
    /// URL: /api/most-popular?page=:page
    /// Example: https://www.episodate.com/api/most-popular?page=1
    public static func popular(_ page: CustomStringConvertible, completionHandler: @escaping (Result<Data, Error>) -> ()) {
        var components = URLComponents()
        components.scheme = "https"
        components.host = "www.episodate.com"
        components.path = "/api/most-popular"
        components.queryItems = [URLQueryItem(name: "page", value: "\(page)")]
        guard let url = components.url else {
            completionHandler(.failure(URLError(.badURL)))
            return
        }
        let request = URLRequest(url: url)
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
