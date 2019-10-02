//
//  BottomSheetController.swift
//  BottomSheet
//
//  Created by Guilherme Ramos on 26/09/19.
//  Copyright © 2019 Progeekt. All rights reserved.
//

import UIKit

final class BottomSheetTransitioningDelegate: NSObject, UIViewControllerTransitioningDelegate {
    private var viewController: UIViewController
    private var presentingViewController: UIViewController

    private var interactiveDismiss: Bool = true

    init(viewController: UIViewController, presentingViewController: UIViewController) {
        self.viewController = viewController
        self.presentingViewController = presentingViewController
        super.init()
    }

    func presentationController(forPresented presented: UIViewController, presenting: UIViewController?, source: UIViewController) -> UIPresentationController? {
        let controller = BottomSheetPresentationController(presentedViewController: presented, presenting: presenting)
        controller.presentationDelegate = source as? BottomSheetPresentationDelegate
        return controller
    }
}
