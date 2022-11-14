import Foundation

public protocol Networking {
    func data(for request: URLRequest) async throws -> (Data, URLResponse)
}
