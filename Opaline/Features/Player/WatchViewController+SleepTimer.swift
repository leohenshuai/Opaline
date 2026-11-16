import UIKit

// MARK: - Sleep timer menu

extension WatchViewController {
    func presentSleepTimerMenu() {
        var options: [(String, SleepTimer.Setting)] = [
            ("sleepTimer.off".localized, .off)
        ]
        for mins in SleepTimer.presetMinutes {
            let title = String(format: "sleepTimer.minutes".localized, mins)
            options.append((title, .minutes(mins)))
        }
        options.append(("sleepTimer.endOfVideo".localized, .endOfVideo))
        let items = options.map { title, value in
            PlayerMenuItem(
                title: value == SleepTimer.shared.setting ? "✓ " + title : title
            ) {
                SleepTimer.shared.set(value)
            }
        }
        presentPlayerMenu(
            title: "settings.row.sleepTimer".localized,
            items: items
        )
    }
}
