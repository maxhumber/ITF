import Foundation
import XCTest

// MARK: - Equatable

// Equatable (for free!)
run(false) {
    struct TVShow: Equatable {
        var name: String
        var network: String
    }
    
    let communityUpToSeason5 = TVShow(name: "Community", network: "NBA")
    let communitySeason6 = TVShow(name: "Community", network: "Yahoo! Screen")
    print(communityUpToSeason5 == communitySeason6)
}

// Custom Equatable
struct TVShow2: Equatable {
    var name: String
    var network: String
    
    static func == (lhs: Self, rhs: Self) -> Bool {
        lhs.name == rhs.name
    }
}

run(false) {
    let communityUpToSeason5 = TVShow2(name: "Community", network: "NBA")
    let communitySeason6 = TVShow2(name: "Community", network: "Yahoo! Screen")
    print(communityUpToSeason5 == communitySeason6)
}

// MARK: - ExpressibleByStringLiteral

// ISO String Dates!
extension Date: ExpressibleByStringLiteral {
    public init(stringLiteral value: String) {
        let formatter = DateFormatter()
        formatter.dateFormat = "yyyy-MM-dd"
        formatter.locale = Locale(identifier: "en_US_POSIX")
        formatter.timeZone = TimeZone(secondsFromGMT: 0)
        self = formatter.date(from: value)!
    }
}

run(false) {
    let date: Date = "2022-11-15"
    print(date)
}

// MARK: - Custom Protocol

// Show Return Status
enum TVShowStatus: Equatable {
    case limbo
    case upcoming(Date)
    case ended(Date? = nil)
}

run(false) {
    let stati: [TVShowStatus] = [.limbo, .upcoming("2022-11-15"), .upcoming("2022-11-16"), .ended()]
    print(stati[0] == .limbo)
    print(stati[3] == .ended())
    print(stati[1] == stati[2])
}

// The "Matchable" Protocol
public protocol Matchable {
    static func ~= (lhs: Self, rhs: Self) -> Bool
}

// Constrain & Gain!
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

run(false) {
    let status1: TVShowStatus = .upcoming("2022-11-15")
    let status2: TVShowStatus = .upcoming("2022-11-16")
    print(status1 ~= status2)
}

// MARK: - Comparable

struct TVShow: Equatable {
    var name: String
    var network: String?
    var status: TVShowStatus
}

// Comparable with precidence given to Status, Date, Alphabet
extension TVShow: Comparable {
    public static func < (lhs: Self, rhs: Self) -> Bool {
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

// Some of my favourite TV shows
run(false) {
    let seinfeld = TVShow(name: "Seinfeld", status: .ended("1998-05-14"))
    let rickAndMorty = TVShow(name: "Rick and Morty", network: "FX", status: .upcoming("2022-11-20"))
    let whiteLotus = TVShow(name: "White Lotus", network: "HBO", status: .upcoming("2022-11-20"))
    let strangerThings = TVShow(name: "Stranger Things", network: "Netflix", status: .limbo)
    let survivor = TVShow(name: "Survivor", network: "CBS", status: .upcoming("2022-11-16"))
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

// Run test suite
run(true) {
    TVShowOrderTests.defaultTestSuite.run()
}

// MARK: - ExpressibleByDictionaryLiteral

run(false) {
    var components = URLComponents()
    components.scheme = "https"
    components.host = "www.episodate.com"
    components.path = "/api/search"
    // super ugly!
    components.queryItems = [URLQueryItem(name: "q", value: "arrow"), URLQueryItem(name: "page", value: "1")]
    let url = components.url!
    let request = URLRequest(url: url)
    print(request.url!)
}

// Make components.queryItems = ... better
@available(iOS 8, *)
extension Array: ExpressibleByDictionaryLiteral where Element == URLQueryItem {
    public init(dictionaryLiteral elements: (String, String?)...) {
        self = elements.map { URLQueryItem(name: $0.0, value: $0.1) }
    }
}

// Function that uses a dictionary definition of query params
func makeUrl(_ query: String, page: Int = 1) -> URL? {
    var components = URLComponents()
    components.scheme = "https"
    components.host = "www.episodate.com"
    components.path = "/api/search"
    components.queryItems = ["q": "arrow", "page": "\(page)"]
    return components.url
}

// Bonus 😜
extension URL: ExpressibleByStringLiteral {
    public init(stringLiteral value: StaticString) {
        self.init(string: "\(value)")!
    }
}

run(false) {
    class URLConstructionTests: XCTestCase {
        func testURLConstruction() throws {
            let result = makeUrl("arrow", page: 2)
            let unwrapped = try XCTUnwrap(result)
            let expected: URL = "https://www.episodate.com/api/search?q=arrow&page=2"
            XCTAssertEqual(unwrapped, expected)
        }
    }
    
    URLConstructionTests.defaultTestSuite.run()
}
