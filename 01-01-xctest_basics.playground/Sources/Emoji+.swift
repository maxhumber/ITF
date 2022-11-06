import Foundation

extension Character {
    public var isEmoji: Bool {
        isSimpleEmoji || isCombinedIntoEmoji
    }
    
    private var isSimpleEmoji: Bool {
        guard let firstScalar = unicodeScalars.first else { return false }
        return firstScalar.properties.isEmoji && firstScalar.value > 0x238C
    }
    
    private var isCombinedIntoEmoji: Bool {
        unicodeScalars.count > 1 && unicodeScalars.first?.properties.isEmoji ?? false
    }
}

extension String {
    public var containsEmoji: Bool {
        contains { $0.isEmoji }
    }
    
    public var containsOnlyEmoji: Bool {
        !isEmpty && !contains { !$0.isEmoji }
    }
    
    public var emojis: [Character] {
        filter { $0.isEmoji }
    }
}
