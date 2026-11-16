import UIKit

// MARK: - Sleep timer icon

extension PlayerIcons {
    /// Crescent moon with a small "z", drawn at the same 26pt template size
    /// as the other top-bar icons so weight and scale match.
    static func sleepTimer() -> UIImage {
        let size = CGSize(width: 26, height: 26)
        let img = UIGraphicsImageRenderer(size: size).image { ctx in
            UIColor.white.setFill()
            circle(at: CGPoint(x: 11.5, y: 14.5), radius: 9).fill()
            ctx.cgContext.setBlendMode(.clear)
            circle(at: CGPoint(x: 16.5, y: 11), radius: 7.5).fill()
            ctx.cgContext.setBlendMode(.normal)
            let attrs: [NSAttributedString.Key: Any] = [
                .font: UIFont.systemFont(ofSize: 11, weight: .heavy),
                .foregroundColor: UIColor.white
            ]
            "z".draw(
                at: CGPoint(x: 16, y: 2),
                withAttributes: attrs
            )
        }
        return img.withRenderingMode(.alwaysTemplate)
    }

    private static func circle(at center: CGPoint, radius: CGFloat) -> UIBezierPath {
        UIBezierPath(
            arcCenter: center,
            radius: radius,
            startAngle: 0,
            endAngle: .pi * 2,
            clockwise: true
        )
    }
}
