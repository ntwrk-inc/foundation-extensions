import Foundation

/// Represent general interface of `Debouncable` object.
public protocol Debouncable: AnyObject {
    typealias ActionHandler = () -> Void

    /// The `Bool` value that indicates that closure is running.
    var isRunning: Bool { get }

    /// Execute closure with delay.
    ///
    /// - Parameters:
    ///   - delay: The amount of time (measured in seconds) to wait before beginning the action.
    ///   Specify a value of 0 to begin the action immediately.
    ///   - action: A block object to be executed.
    func run(delay: TimeInterval, action: @escaping ActionHandler)

    /// Cancel all running tasks.
    func cancel()
}
