import UIKit

enum Side {
    case top, left, bottom, right, edges
}

extension UIView {
    func constrain(side: Side, distance: CGFloat) {
        translatesAutoresizingMaskIntoConstraints = false
        NSLayoutConstraint.activate(
            [
                topAnchor.constraint(equalTo: superview!.topAnchor, constant: distance),
                leftAnchor.constraint(equalTo: superview!.leftAnchor, constant: distance),
                rightAnchor.constraint(equalTo: superview!.rightAnchor, constant: distance),
                bottomAnchor.constraint(equalTo: superview!.bottomAnchor, constant: distance)
            ]
        )
    }
}
