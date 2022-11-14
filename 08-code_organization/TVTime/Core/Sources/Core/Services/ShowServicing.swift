import Foundation

public protocol ShowServicing {
    func popular(_ page: Int) async throws -> [Show]
}
