import Foundation

public extension Array {
    /// Safe getting element from array by index.
    subscript(safe index: Int) -> Element? {
        (0 ..< count).contains(index) ? self[index] : nil
    }
}
