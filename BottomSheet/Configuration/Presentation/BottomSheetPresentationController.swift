//
//  BottomSheetPresentationController.swift
//  BottomSheet
//
//  Created by Guilherme Ramos on 26/09/19.
//  Copyright © 2019 Progeekt. All rights reserved.
//

import UIKit

final class BottomSheetPresentationController: UIPresentationController {
    private let kDimOpacity: CGFloat = 0.7
    
    weak var presentationDelegate: BottomSheetPresentationDelegate?

    override var frameOfPresentedViewInContainerView: CGRect {
        if let delegateFrame = presentationDelegate?.frameOfPresentedViewInContainerView {
            return delegateFrame
        } else {
            guard let containerView = containerView else {
                return .zero
            }
            let halfHeight = containerView.bounds.height / 2
            return CGRect(
                x: 0,
                y: halfHeight,
                width: containerView.bounds.width,
                height: halfHeight
            )
        }
    }

    private lazy var dimView: UIView! = {
        guard let containerView = containerView else { return nil }

        let view = UIView(frame: containerView.bounds)
        
        view.addGestureRecognizer (
            UITapGestureRecognizer(target: self, action: #selector(tapGesture(_:)))
        )

        return view
    }()

    override init(presentedViewController: UIViewController, presenting presentingViewController: UIViewController?) {
        super.init(presentedViewController: presentedViewController, presenting: presentingViewController)

        if let control = presentedViewController.view.subviews.first(where: { $0.accessibilityIdentifier == "BottomSheetHandler"}) as? UIControl {
            control.addGestureRecognizer(
                UITapGestureRecognizer(target: self, action: #selector(tapGesture(_:)))
            )
        }

        presentedViewController.view.addGestureRecognizer(
            UIPanGestureRecognizer(target: self, action: #selector(panGesture(_:)))
        )
    }

    // MARK: - Background Configuration

    private func configBackground() {
        if let backgroundColor = presentationDelegate?.backgroundColor {
            dimView?.backgroundColor = backgroundColor
        } else {
            dimView?.backgroundColor = UIColor.black.withAlphaComponent(0.7)
        }
    }

    // MARK: - Overriden properties

    override func presentationTransitionWillBegin() {
        guard let containerView = containerView,
            let coordinator = presentingViewController.transitionCoordinator else {
                return
        }
        dimView.alpha = 0
        configBackground()
        containerView.addSubview(dimView)
        dimView.addSubview(presentedViewController.view)

        coordinator.animate(alongsideTransition: { [weak self] context in
            self?.dimView.alpha = 1
        })
    }

    override func dismissalTransitionWillBegin() {
        guard let coordinator = presentingViewController.transitionCoordinator else {
            return
        }

        coordinator.animate(alongsideTransition: { [weak self] context in
            self?.dimView.alpha = 0
        })
    }

    override func dismissalTransitionDidEnd(_ completed: Bool) {
        if completed {
            dimView.removeFromSuperview()
        }
    }

    // MARK: - Interactions

    @objc private func tapGesture(_ recognizer: UITapGestureRecognizer) {
        presentedViewController.dismiss(animated: true)
    }

    @objc private func panGesture(_ recognizer: UIPanGestureRecognizer) {
        guard
            let view = recognizer.view,
            let presentedView = presentedView,
            let containerView = containerView
            else {
                return
        }
        let translation = recognizer.translation(in: view)
        let direction = BottomSheetPanDirection(value: translation.y, currentPosition: view.frame.origin.y)

        switch recognizer.state {
        case .began:
            presentedView.frame.size.height = containerView.frame.height
        case .changed:
            Translation.translate(presentedViewController, direction: direction)
        case .ended:
            Translation.adjust(
                presented: presentedViewController,
                presenting: presentingViewController,
                position: direction.position,
                frameOfPresentedViewInContainerView: frameOfPresentedViewInContainerView
            )
        default: break
        }
        recognizer.setTranslation(.zero, in: view)
    }

}
