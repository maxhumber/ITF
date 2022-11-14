import XCTest
@testable import Core

final class CoreTests: XCTestCase {
    func testExample() async throws {
        let service = ShowService()
        let shows = try await service.popular(1)
        print(shows)
    }
}
