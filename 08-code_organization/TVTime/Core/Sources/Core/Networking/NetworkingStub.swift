import Foundation

public class NetworkingStub: Networking {
    private var result: Result<Data, Error>
    
    public init(_ result: Result<Data, Error>) {
        self.result = result
    }
    
    public func data(for request: URLRequest) async throws -> (Data, URLResponse) {
        try (result.get(), URLResponse())
    }
}
