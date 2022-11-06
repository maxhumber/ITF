import Foundation
import XCTest

/// Keep everything neat and tidy!
func block(_ title: String? = nil, silence: Bool = false, code: @escaping () -> Void) {
    if silence { return }
    code()
}

block("Equatable - For Free", silence: true) {
    /// Basic TV Show + Equatable
    struct TVShow: Equatable {
        var name: String
        var network: String
    }
    
    let communityUpToSeason5 = TVShow(name: "Community", network: "NBA")
    let communitySeason6 = TVShow(name: "Community", network: "Yahoo! Screen")
    
    print(communityUpToSeason5 == communitySeason6)
}

block("Equatable - Custom", silence: true) {
    let communityUpToSeason5 = ForgivingTVShow(name: "Community", network: "NBA")
    let communitySeason6 = ForgivingTVShow(name: "Community", network: "Yahoo! Screen")
    print(communityUpToSeason5 == communitySeason6)
    
    /// Forgiving... with custom == definition
    struct ForgivingTVShow: Equatable {
        var name: String
        var network: String
        
        static func == (lhs: Self, rhs: Self) -> Bool {
            lhs.name == rhs.name
        }
    }
}

/// ExpressibleByStringLiteral... so useful!
extension Date: ExpressibleByStringLiteral {
    public init(stringLiteral value: String) {
        let formatter = DateFormatter()
        formatter.dateFormat = "yyyy-MM-dd"
        self = formatter.date(from: value)!
    }
}

block("String Dates", silence: true) {
    let date: Date = "2022-11-15"
    print(date)
}

enum TVShowStatus: Equatable {
    case limbo
    case upcoming(Date)
    case ended(Date? = nil)
}

block("The 'problem' with enum + Equatable", silence: true) {
    let stati: [TVShowStatus] = [.limbo, .upcoming("2022-11-15"), .upcoming("2022-11-16"), .ended()]
    print(stati[0] == .limbo)
    print(stati[3] == .ended())
    print(stati[1] == stati[2])
}

// Our own protocol!
public protocol Matchable {
    static func ~= (lhs: Self, rhs: Self) -> Bool
}

// (Constrain & Gain!)
extension TVShowStatus: Matchable {
    public static func ~= (lhs: Self, rhs: Self) -> Bool {
        switch (lhs, rhs) {
        case (.limbo, .limbo): return true
        case (.ended, .ended): return true
        case (.upcoming, .upcoming): return true
        default: return false
        }
    }
}

block("Enum + Matchable!", silence: false) {
    let status1: TVShowStatus = .upcoming("2022-11-15")
    let status2: TVShowStatus = .upcoming("2022-11-16")
    print(status1 ~= status2)
}

// Outside of block so that it sticks around...
struct TVShow: Equatable {
    var name: String
    var network: String?
    var status: TVShowStatus
}

// A Testable Problem!

// Order: Status, Date, Alphabet
let seinfeld = TVShow(name: "Seinfeld", status: .ended("1998-05-14"))
let rickAndMorty = TVShow(name: "Rick and Morty", network: "FX", status: .upcoming("2022-11-20"))
let whiteLotus = TVShow(name: "White Lotus", network: "HBO", status: .upcoming("2022-11-20"))
let strangerThings = TVShow(name: "Stranger Things", network: "Netflix", status: .limbo)
let survivor = TVShow(name: "Survivor", network: "CBS", status: .upcoming("2022-11-16"))

// survivor > rick and morty > white lotus > stranger things, seinfeld

extension TVShow: Comparable {
    static func < (lhs: Self, rhs: Self) -> Bool {
        switch (lhs.status, rhs.status) {
        case (.upcoming(let lhsDate), .upcoming(let rhsDate)):
            return lhsDate < rhsDate
        case (.upcoming, _):
            return true
        case (_, .upcoming):
            return false
        case (.limbo, .ended):
            return true
        case (.ended, .limbo):
            return false
        default:
            return lhs.name > rhs.name
        }
    }
}

class TVShowOrderTests: XCTestCase {
    func testTVShows() {
        let shows = [
            TVShow(name: "Seinfeld", status: .ended("1998-05-14")),
            TVShow(name: "Rick and Morty", network: "FX", status: .upcoming("2022-11-20")),
            TVShow(name: "White Lotus", network: "HBO", status: .upcoming("2022-11-20")),
            TVShow(name: "Stranger Things", network: "Netflix", status: .limbo),
            TVShow(name: "Survivor", network: "CBS", status: .upcoming("2022-11-16"))
        ]
        let expected = ["Survivor", "Rick and Morty", "White Lotus", "Stranger Things", "Seinfeld"]
        let result = shows.sorted(by: <).map(\.name)
        XCTAssertEqual(result, expected)
    }
}

TVShowOrderTests.defaultTestSuite.run()

block("Query Items Suck...", silence: false) {
    var components = URLComponents()
    components.scheme = "https"
    components.host = "www.episodate.com"
    components.path = "/api/search"
    components.queryItems = [URLQueryItem(name: "q", value: "arrow"), URLQueryItem(name: "page", value: "1")]
    let url = components.url!
    let request = URLRequest(url: url)
    print(request.url!)
}

// Make them better!
@available(iOS 8, *)
extension Array: ExpressibleByDictionaryLiteral where Element == URLQueryItem {
    public init(dictionaryLiteral elements: (String, String?)...) {
        self = elements.map { URLQueryItem(name: $0.0, value: $0.1) }
    }
}

extension URL: ExpressibleByStringLiteral {
    public init(stringLiteral value: StaticString) {
        self.init(string: "\(value)")!
    }
}

func makeUrl(_ query: String, page: Int = 1) -> URL? {
    var components = URLComponents()
    components.scheme = "https"
    components.host = "www.episodate.com"
    components.path = "/api/search"
    components.queryItems = ["q": "arrow", "page": "\(page)"]
    return components.url
}

class URLConstructionTests: XCTestCase {
    func testURLConstruction() throws {
        let result = makeUrl("arrow", page: 2)
        let unwrapped = try XCTUnwrap(result)
        let expected: URL = "https://www.episodate.com/api/search?q=arrow&page=2"
        XCTAssertEqual(unwrapped, expected)
    }
}

URLConstructionTests.defaultTestSuite.run()
