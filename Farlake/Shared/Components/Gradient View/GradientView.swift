//
//  GradientView.swift
//  Farlake
//
//  Created by Boy van Amstel on 08/07/2020.
//  Copyright © 2020 Boy van Amstel. All rights reserved.
//

import UIKit

/// Draws a gradient that resizes with Auto Layout changes.
class GradientView: UIView {

    private let gradient: CAGradientLayer = CAGradientLayer()

    // MARK: - Object lifecycle

    init(colors: [UIColor]) {
        gradient.colors = colors.map { $0.cgColor }

        super.init(frame: .zero)

        layer.addSublayer(gradient)
    }

    required init?(coder aDecoder: NSCoder) { fatalError("init(coder:) has not been implemented") }

    // MARK: - Layout

    override func layoutSublayers(of layer: CALayer) {
        super.layoutSublayers(of: layer)

        UIView.performWithoutAnimation {
            gradient.frame = self.bounds
        }
    }

}
