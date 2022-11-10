import Foundation

public struct EpisodateResult: Codable {
    public var total: String?
    public var page: Int?
    public var pages: Int?
    public var shows: [TVShow]
    
    public init(shows: [TVShow]) {
        self.shows = shows
    }
    
    private enum CodingKeys: String, CodingKey {
        case shows = "tv_shows"
        case page
        case pages
        case total
    }
}
