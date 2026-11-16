import UIKit

// MARK: - Sleep timer button
//
// Top control row, left of the loop button. Tinted with the accent colour
// while a timer is running; tapping opens the duration menu.

extension VideoPlayerView {
    func configureSleepButton() {
        if #available(iOS 14.0, *),
           let icon = UIImage(systemName: "moon.zzz") {
            sleepButton.setImage(icon, for: .normal)
        } else {
            sleepButton.setTitle("Zz", for: .normal)
            sleepButton.titleLabel?.font = UIFont.systemFont(
                ofSize: 13,
                weight: .bold
            )
        }
        sleepButton.accessibilityLabel = "settings.row.sleepTimer".localized
        sleepButton.translatesAutoresizingMaskIntoConstraints = false
        sleepButton.addTarget(
            self,
            action: #selector(sleepTapped),
            for: .touchUpInside
        )
        sleepButton.addTapFeedback()
        updateSleepButton()
        controlsView.addSubview(sleepButton)
        activateSleepConstraints()
        NotificationCenter.default.addObserver(
            self,
            selector: #selector(updateSleepButton),
            name: SleepTimer.didChange,
            object: nil
        )
    }

    private func activateSleepConstraints() {
        NSLayoutConstraint.activate([
            sleepButton.centerYAnchor.constraint(
                equalTo: settingsButton.centerYAnchor
            ),
            sleepButton.trailingAnchor.constraint(
                equalTo: loopButton.leadingAnchor, constant: -4
            ),
            sleepButton.widthAnchor.constraint(equalToConstant: 36),
            sleepButton.heightAnchor.constraint(equalToConstant: 36)
        ])
    }

    @objc
    func updateSleepButton() {
        sleepButton.tintColor = SleepTimer.shared.setting == .off
            ? .white
            : ThemeManager.shared.accent
        sleepButton.setTitleColor(sleepButton.tintColor, for: .normal)
    }

    @objc
    private func sleepTapped() {
        delegate?.videoPlayerViewDidTapSleepTimer(self)
    }
}
