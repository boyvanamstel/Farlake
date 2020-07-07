//
//  UIImage+Helpers.swift
//  Farlake
//
//  Created by Boy van Amstel on 07/07/2020.
//  Copyright © 2020 Boy van Amstel. All rights reserved.
//
//  Based on https://nshipster.com/image-resizing/

import UIKit
import func AVFoundation.AVMakeRect

extension UIImage {
    /// Returns a new UIImage that's been resized to fill the supplied rect.
    /// - Parameters:
    ///   - contentMode: The mode to use for resizing.
    ///   - rect: The rect to fill or fit in.
    /// - Returns: A new image that's been resized.
    func resize(using contentMode: UIView.ContentMode, in rect: CGRect) -> UIImage {
        switch contentMode {
        case .scaleAspectFit: return scaleAspectFit(rect)
        case .scaleToFill: return scaleToFill(rect)
        default:
            fatalError("Resize mode has not been implented yet.")
        }
    }

    private func scaleAspectFit(_ rect: CGRect) -> UIImage {
        let rect = AVMakeRect(aspectRatio: size, insideRect: rect)
        let renderer = UIGraphicsImageRenderer(size: rect.size)

        return renderer.image { (context) in
            draw(in: CGRect(origin: rect.origin, size: rect.size))
        }
    }

    private func scaleToFill(_ rect: CGRect) -> UIImage {
        let newSize = size.aspectFill(rect.size)
        let newOrigin = CGPoint(x: (newSize.width - rect.width) / 2.0, y: (newSize.height - rect.height) / 2.0)

        let renderer = UIGraphicsImageRenderer(size: newSize)

        return renderer.image { (context) in
            draw(in: CGRect(origin: newOrigin, size: newSize))
        }
    }
}
