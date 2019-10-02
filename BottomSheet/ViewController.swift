//
//  ViewController.swift
//  BottomSheet
//
//  Created by Guilherme Ramos on 26/09/19.
//  Copyright © 2019 Progeekt. All rights reserved.
//

import UIKit

final class ViewController: UIViewController {
    private var bottomSheetTransitioningDelegate: BottomSheetTransitioningDelegate?

    private var listController: ListViewController!
    private var bottomSheetController: BottomSheetController!

    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = .white
    }
    
    override func viewDidAppear(_ animated: Bool) {
        super.viewDidAppear(animated)
        setup()
        present(bottomSheetController, animated: true)
    }
}

extension ViewController: BaseConfiguration {
    func configViews() {
        listController = ListViewController()
        listController.collectionView.delegate = self
        bottomSheetController = BottomSheetController(with: listController)

        let style: BottomSheetStyle = [
            .rounded(radius: 15, masksToBounds: false),
            .shadowed(radius: 10, opacity: 0.4, offset: CGSize(width: 0, height: -1))
        ]
        bottomSheetController.apply(style: style)

        bottomSheetTransitioningDelegate = BottomSheetTransitioningDelegate(viewController: self, presentingViewController: bottomSheetController)
        bottomSheetController.transitioningDelegate = bottomSheetTransitioningDelegate
    }

    func configConstraints() { }
}

extension ViewController: UICollectionViewDelegateFlowLayout {
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {

    }
}

extension ViewController: BottomSheetPresentationDelegate {
    var backgroundColor: UIColor? {
        return UIColor.black.withAlphaComponent(0.5)
    }

    var frameOfPresentedViewInContainerView: CGRect {
        let height =  view.frame.height / 4
        return CGRect(
            x: 0,
            y: view.frame.height - height,
            width: view.frame.width,
            height:  height
        )
    }
}

