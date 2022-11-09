import Foundation

public struct TVShow: Codable {
    public var name: String
    public var network: String?
    public var status: String
    public var startDate: Date
    public var endDate: Date?
    public var thumbnail: URL
    
    private enum CodingKeys: String, CodingKey {
        case name
        case network
        case status
        case startDate = "start_date"
        case endDate = "end_date"
        case thumbnail = "image_thumbnail_path"
    }
}
