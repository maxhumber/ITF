import Foundation

public enum ThirdPartyAPI {
    public static func canAndWillThrow() throws {
        throw "Error!"
    }
    
    public static func canButWontThrow() throws -> Int {
        return 42
    }
}
