//
//  BottomSheetController.swift
//  BottomSheet
//
//  Created by Guilherme Ramos on 26/09/19.
//  Copyright © 2019 Progeekt. All rights reserved.
//

import UIKit

final class BottomSheetController: UIViewController {
    var style: BottomSheetStyle = []
    var type: BottomSheetControllerType = .collection

    private var contentViewController: UIViewController

    // MARK: - Views

    private let button: UIButton = {
        let button = UIButton(type: .custom)
        button.tintColor = .gray
        button.accessibilityIdentifier = "BottomSheetHandler"
        button.setImage(UIImage(named: "BottomSheetShapeIcon"), for: [])
        button.contentVerticalAlignment = .center
        button.contentHorizontalAlignment = .center
        return button
    }()

    private let contentView = UIView()

    init(with contentViewController: UIViewController) {
        self.contentViewController = contentViewController
        super.init(nibName: nil, bundle: nil)
        super.modalPresentationStyle = .custom
    }

    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }

    override func viewDidLoad() {
        super.viewDidLoad()
        setup()
    }

    func apply(style: BottomSheetStyle) {
        style.forEach { attribute in
            attribute.apply(on: view)
        }
    }
}

extension BottomSheetController: BaseConfiguration {
    func configViews() {
        view.backgroundColor = .white

        view.addSubview(button)
        view.addSubview(contentView)

        // MARK: - ContentViewController Config
        addChild(contentViewController)
        contentView.addSubview(contentViewController.view)
        contentViewController.didMove(toParent: self)
    }

    func configConstraints() {
        button.preservesSuperviewLayoutMargins = true
        button.translatesAutoresizingMaskIntoConstraints = false

        contentView.preservesSuperviewLayoutMargins = true
        contentView.translatesAutoresizingMaskIntoConstraints = false

        NSLayoutConstraint.activate([
            button.heightAnchor.constraint(equalToConstant: 40),
            button.topAnchor.constraint(equalTo: button.superview!.topAnchor, constant: 0),
            button.leftAnchor.constraint(equalTo: button.superview!.leftAnchor, constant: 0),
            button.rightAnchor.constraint(equalTo: button.superview!.rightAnchor, constant: 0),

            contentView.topAnchor.constraint(equalTo: button.bottomAnchor, constant: 0),
            contentView.leftAnchor.constraint(equalTo: contentView.superview!.leftAnchor, constant: 0),
            contentView.rightAnchor.constraint(equalTo: contentView.superview!.rightAnchor, constant: 0),
            contentView.bottomAnchor.constraint(equalTo: contentView.superview!.bottomAnchor, constant: 0),
            ])
    }
}
