import Foundation

struct EpisodateResult: Codable {
    var total: String?
    var page: Int?
    var pages: Int?
    var shows: [Show]
    
    private enum CodingKeys: String, CodingKey {
        case shows = "tv_shows"
        case page
        case pages
        case total
    }
}

