import Foundation

struct Show: Codable, Equatable, Identifiable {
    var id: Int
    var name: String
    var network: String?
    var status: String
    var startDate: Date
    var endDate: Date?
    var thumbnail: URL
    
    private enum CodingKeys: String, CodingKey {
        case id
        case name
        case network
        case status
        case startDate = "start_date"
        case endDate = "end_date"
        case thumbnail = "image_thumbnail_path"
    }
}
