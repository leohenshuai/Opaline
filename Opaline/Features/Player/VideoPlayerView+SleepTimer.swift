import UIKit

// MARK: - Sleep timer button
//
// Top control row, directly left of the audio-only button. The loop button
// sits further left and is hidden for queues, so it is not the anchor.
// Tinted with the accent colour while a timer is running.

extension VideoPlayerView {
    func configureSleepButton() {
        sleepButton.setImage(PlayerIcons.sleepTimer(), for: .normal)
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
                equalTo: audioOnlyButton.leadingAnchor, constant: -4
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
    }

    @objc
    private func sleepTapped() {
        delegate?.videoPlayerViewDidTapSleepTimer(self)
    }
}
