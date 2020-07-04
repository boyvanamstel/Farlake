//
//  GalleryViewContontroller.swift
//  Farlake
//
//  Created by Boy van Amstel on 04/07/2020.
//  Copyright © 2020 Boy van Amstel. All rights reserved.
//

import UIKit

protocol GalleryViewControllerDelegate: AnyObject {}

/// Contains the gallery.
final class GalleryViewController: UIViewController {
    weak var delegate: GalleryViewControllerDelegate?
}
