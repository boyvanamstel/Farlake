//
//  CGSize+Helpers.swift
//  Farlake
//
//  Created by Boy van Amstel on 07/07/2020.
//  Copyright © 2020 Boy van Amstel. All rights reserved.
//

import UIKit

extension CGSize {
    init(equal value: CGFloat) {
        self.init(width: value, height: value)
    }

    /// Calculates the size to fill an area.
    /// - Parameter targetSize: The target size to fill.
    /// - Returns: Returns the new size to scale the item to.
    func aspectFill(_ targetSize: CGSize) -> CGSize {
        let wRatio = targetSize.width / width
        let hRatio = targetSize.height / height
        let scale = max(wRatio, hRatio)

        return applying(CGAffineTransform(scaleX: scale, y: scale))
    }
}
