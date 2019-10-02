//
//  Translation.swift
//  BottomSheet
//
//  Created by Guilherme Ramos on 26/09/19.
//  Copyright © 2019 Progeekt. All rights reserved.
//

import UIKit

struct Translation {

    /// Adjust the origin of the frame based on the translation position on screen
    ///
    /// - Parameters:
    ///   - viewController: selected viewcontroller in the tanslation action
    ///   - direction: direction of the translation
    static func translate(
        _ viewController: UIViewController,
        direction: BottomSheetPanDirection
    ) {
        // Make sure views do exist
        guard let presentedView = viewController.view else {
            return
        }

        switch direction {
        case let .upwards(position), let .downwards(position):
            presentedView.frame.origin.y = position
        default: break
        }
    }

    private static func presentedViewFrame(from presentingView: UIView, topOffset: CGFloat) -> CGRect {
        return CGRect(
            x: 0,
            y: topOffset,
            width: presentingView.bounds.width,
            height: presentingView.bounds.height - topOffset
        )
    }


    /// Adjust the frame bsased on the position of the translated viewController
    ///
    /// - Parameters:
    ///   - presentedViewController: Selected viewController on the translation interaction
    ///   - presentingViewController: ViewController that has presented the selected controller
    ///   - position: Position of the screen after a translation
    ///   - frameOfPresentedViewInContainerView: Default frame of view in transition
    ///   - completion: Completion block for a dismiss action
    static func adjust(
        presented presentedViewController: UIViewController,
        presenting presentingViewController: UIViewController,
        position: CGFloat,
        frameOfPresentedViewInContainerView: CGRect,
        completion: (() -> Void)? = nil
    ) {
        guard
            let presentedView = presentedViewController.view,
            let presentingView = presentingViewController.view
        else {
            return
        }
        
        let halfwayBottom = presentingView.frame.midY * 1.5

        switch position {
        case ..<frameOfPresentedViewInContainerView.origin.y:
            UIView.animate(
                withDuration: 0.8,
                delay: 0,
                usingSpringWithDamping: 0.5,
                initialSpringVelocity: 0.5,
                options: .curveEaseInOut,
                animations: {
                    presentedView.frame = frameOfPresentedViewInContainerView
            })
        case halfwayBottom...:
            presentedViewController.dismiss(animated: true, completion: completion)
        default: break
        }
    }

}
