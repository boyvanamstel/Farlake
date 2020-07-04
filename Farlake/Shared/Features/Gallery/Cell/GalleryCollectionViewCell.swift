//
//  GalleryCollectionViewCell.swift
//  Farlake
//
//  Created by Boy van Amstel on 04/07/2020.
//  Copyright © 2020 Boy van Amstel. All rights reserved.
//

import UIKit

final class GalleryCollectionViewCell: UICollectionViewCell {
    static let reuseIdentifier = "GalleryCollectionViewCell"

    @IBOutlet var titleField: UILabel!
    @IBOutlet var imageView: UIImageView!

    var viewModel: GalleryCollectionViewCellViewModel? {
        didSet {
            titleField.text = viewModel?.title ?? ""
            imageView.image = viewModel?.image
        }
    }
}
