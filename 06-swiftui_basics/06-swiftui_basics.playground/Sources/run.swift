import Foundation

public func run(_ runCode: Bool = true, code: () -> Void) {
    guard runCode else { return }
    code()
}
