//
//  GalleryCollectionViewCellViewModel.swift
//  Farlake
//
//  Created by Boy van Amstel on 04/07/2020.
//  Copyright © 2020 Boy van Amstel. All rights reserved.
//

import UIKit

struct GalleryCollectionViewCellViewModel {
    let artwork: Artwork

    init(artwork: Artwork) {
        self.artwork = artwork
    }

    var image: UIImage? { artwork.image }
    var title: String { artwork.title }
}
