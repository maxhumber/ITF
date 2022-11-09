import Foundation

extension Data {
    public func stringify() -> String {
        do {
            let json = try JSONSerialization.jsonObject(with: self, options: [])
            let data = try JSONSerialization.data(withJSONObject: json, options: .prettyPrinted)
            guard let string = String(data: data, encoding: .utf8) else { fatalError() }
            let pastableString = string
                .replacingOccurrences(of: #"\/"#, with: "/", options: .literal, range: nil)
                .replacingOccurrences(of: "\" : ", with: "\": ", options: .literal, range: nil)
            return pastableString
        } catch {
            fatalError()
        }
    }
}
