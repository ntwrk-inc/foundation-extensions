import Foundation

public final class Debouncer: Debouncable {
    // MARK: Public

    public var isRunning: Bool {
        !(dispatchWorkItem?.isCancelled ?? true)
    }

    public func run(delay: TimeInterval, action: @escaping ActionHandler) {
        cancel()
        _run(delay: delay, action)
    }

    public func cancel() {
        dispatchWorkItem?.cancel()
    }

    // MARK: Private

    private var dispatchWorkItem: DispatchWorkItem?

    private func _run(delay: TimeInterval, _ closure: @escaping ActionHandler) {
        let dispatchWorkItem = DispatchWorkItem(block: closure)

        DispatchQueue.main.asyncAfter(
            deadline: .now() + delay,
            execute: dispatchWorkItem
        )

        self.dispatchWorkItem = dispatchWorkItem
    }
}
