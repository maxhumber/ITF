import Foundation

public struct TVShow: Codable, Equatable {
    public var name: String
    public var network: String?
    public var status: String
    public var startDate: Date?
    public var endDate: Date?
    public var thumbnail: URL?
    
    public init(name: String, network: String? = nil, status: String, startDate: Date? = nil, endDate: Date? = nil, thumbnail: URL? = nil) {
        self.name = name
        self.network = network
        self.status = status
        self.startDate = startDate
        self.endDate = endDate
        self.thumbnail = thumbnail
    }
    
    private enum CodingKeys: String, CodingKey {
        case name
        case network
        case status
        case startDate = "start_date"
        case endDate = "end_date"
        case thumbnail = "image_thumbnail_path"
    }
}
