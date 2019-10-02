//
//  BottomSheetPresentationDelegate.swift
//  BottomSheet
//
//  Created by Guilherme Ramos on 26/09/19.
//  Copyright © 2019 Progeekt. All rights reserved.
//

import UIKit

protocol BottomSheetPresentationDelegate: AnyObject {

    /// This property will define the dim color
    /// defaults to .black.withAlphaComponent(0.7)
    var backgroundColor: UIColor? { get }

    /// This property specifies the size and origin of your bottom
    /// defaults to half of the screen
    var frameOfPresentedViewInContainerView: CGRect { get }
}
