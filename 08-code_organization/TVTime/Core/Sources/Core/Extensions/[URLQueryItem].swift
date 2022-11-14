import Foundation

extension Array: ExpressibleByDictionaryLiteral where Element == URLQueryItem {
    public init(dictionaryLiteral elements: (String, String?)...) {
        self = elements.map { URLQueryItem(name: $0.0, value: $0.1) }
    }
}
