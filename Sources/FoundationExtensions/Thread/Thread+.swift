import Foundation

public extension Thread {
    /// Name of the current thread.
    var threadName: String {
        if let currentOperationQueue = OperationQueue.current?.name {
            return "OperationQueue: \(currentOperationQueue)"
        } else if let underlyingDispatchQueue = OperationQueue.current?.underlyingQueue?.label {
            return "DispatchQueue: \(underlyingDispatchQueue)"
        } else {
            let name = __dispatch_queue_get_label(nil)
            return String(cString: name, encoding: .utf8) ?? Thread.current.description
        }
    }
}

/// Run closure on main thread.
///
/// - Parameter run: A completion block that will executed on main thread.
public func onMain(run: @escaping () -> Void) {
    DispatchQueue.main.async {
        run()
    }
}

/// Background serial queue.
let backgroundThread = DispatchQueue(label: "com.foundation-extensions.thread")

/// Run closure on background
///
/// - Parameter run: A completion block that will executed on background thread.
public func onBackground(run: @escaping () -> Void) {
    backgroundThread.async {
        run()
    }
}

/// Execute closure on main thread.
///
/// - Parameter work: A block based object to be executed on main thread.
public func ensureMainThread(execute work: @escaping @convention(block) () -> Swift.Void) {
    if Thread.isMainThread {
        work()
    } else {
        onMain {
            work()
        }
    }
}
