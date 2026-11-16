import Foundation

/// Sleep timer: pauses playback after a chosen delay, or when the current
/// video ends. Not persisted — it resets on app relaunch.
final class SleepTimer {
    enum Setting: Equatable {
        case off
        case minutes(Int)
        case endOfVideo
    }

    static let shared = SleepTimer()
    static let didChange = Notification.Name("sleepTimerDidChange")
    static let presetMinutes = [15, 30, 45, 60, 90, 120]

    private(set) var setting: Setting = .off
    private var timer: Timer?

    var displayName: String {
        switch setting {
        case .off:
            return "sleepTimer.off".localized
        case .minutes(let m):
            return String(format: "sleepTimer.minutes".localized, m)
        case .endOfVideo:
            return "sleepTimer.endOfVideo".localized
        }
    }

    private init() {}

    func set(_ new: Setting) {
        timer?.invalidate()
        timer = nil
        setting = new
        if case .minutes(let m) = new {
            let t = Timer(timeInterval: TimeInterval(m * 60), repeats: false) { [weak self] _ in
                self?.fire()
            }
            // .common so it still fires while scrolling / in background audio.
            RunLoop.main.add(t, forMode: .common)
            timer = t
        }
        NotificationCenter.default.post(name: Self.didChange, object: nil)
    }

    /// Called when a video finishes. Returns true when the timer consumed
    /// the end event (caller must not advance to the next video).
    func consumeVideoEnd() -> Bool {
        guard setting == .endOfVideo else {
            return false
        }
        set(.off)
        return true
    }

    private func fire() {
        set(.off)
        NowPlayingService.shared.pauseForSleepTimer()
    }
}
