//
//  BottomSheetControllerConfig.swift
//  BottomSheet
//
//  Created by Guilherme Ramos on 26/09/19.
//  Copyright © 2019 Progeekt. All rights reserved.
//

import UIKit

// MARK: - Bottomsheet controller types

enum BottomSheetControllerType {
    case collection
    case custom
}

// MARK: - Style Configuration

typealias BottomSheetStyle = [BottomSheetControllerStyle]
enum BottomSheetControllerStyle {
    case rounded(radius: CGFloat, masksToBounds: Bool)
    case shadowed(radius: CGFloat, opacity: CGFloat, offset: CGSize)
    case square

    func apply(on view: UIView) {
        switch self {
        case .shadowed:
            applyShadow(on: view)
        case .rounded:
            applyRoundedBorders(on: view)
        case .square:
            break
        }
    }

    private func applyShadow(on view: UIView) {
        guard case let .shadowed(radius, opacity, offset) = self else {
            return
        }

        view.layer.shadowOpacity = Float(opacity)
        view.layer.shadowRadius = radius
        view.layer.shadowOffset = offset
    }

    private func applyRoundedBorders(on view: UIView) {
        guard case let .rounded(radius, masksToBounds) = self else {
            return
        }

        view.layer.cornerRadius = radius
        view.layer.masksToBounds = masksToBounds
    }
}

// MARK: - Cells configuration

protocol BottomSheetCell: Reusable {
    associatedtype Item

    static var itemSize: CGSize { get set }

    func config(_ item: Item)
}

extension BottomSheetCell where Self: UICollectionViewCell {
    static var itemSize: CGSize {
        return .zero
    }
}

extension BottomSheetCell where Self: UITableViewCell {
    static var itemSize: CGSize {
        return .zero
    }
}


// MARK: - Direction Configuration

enum BottomSheetAnimatorType {
    case dismiss
    case present
}

enum BottomSheetPanDirection {
    case upwards(position: CGFloat)
    case downwards(position: CGFloat)
    case stop(position: CGFloat)

    init(value: CGFloat, currentPosition: CGFloat) {
        if value < 0 {
            self = .upwards(position: (currentPosition - abs(value)))
        } else if value > 0 {
            self = .downwards(position: (currentPosition + abs(value)))
        } else {
            self = .stop(position: currentPosition)
        }
    }

    var position: CGFloat {
        switch self {
            case let .upwards(pos),
                 let .downwards(pos),
                 let .stop(pos):
            return pos
        }
    }
}
