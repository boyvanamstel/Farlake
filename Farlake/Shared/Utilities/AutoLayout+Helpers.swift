//
//  AutoLayout+Helpers.swift
//  Farlake
//
//  Created by Boy van Amstel on 04/07/2020.
//  Copyright © 2020 Boy van Amstel. All rights reserved.
//

import UIKit

extension UIView {
    func pin(to view: UIView, constraints: [Constraint]) {
        constraints.forEach { $0(self, view).isActive = true }
    }
}

// Based on https://www.objc.io/blog/2018/10/30/auto-layout-with-key-paths/

typealias Constraint = (UIView, UIView) -> NSLayoutConstraint

// MARK: - Equal

func equal<L, Axis>(_ to: KeyPath<UIView, L>, constant: CGFloat = 0.0, priority: UILayoutPriority = .required) -> Constraint where L: NSLayoutAnchor<Axis> {
    return equal(to, to, constant: constant, priority: priority)
}

func equal<L, Axis>(_ from: KeyPath<UIView, L>, _ to: KeyPath<UIView, L>, constant: CGFloat = 0.0, priority: UILayoutPriority = .required) -> Constraint where L: NSLayoutAnchor<Axis> {
    return { view1, view2 in
        let constraint = view1[keyPath: from].constraint(equalTo: view2[keyPath: to], constant: constant)
        constraint.priority = priority

        return constraint
    }
}

func equal<L>(_ keyPath: KeyPath<UIView, L>, constant: CGFloat = 0.0, priority: UILayoutPriority = .required) -> Constraint where L: NSLayoutDimension {
    return { view1, _ in
        let constraint = view1[keyPath: keyPath].constraint(equalToConstant: constant)
        constraint.priority = priority

        return constraint
    }
}
