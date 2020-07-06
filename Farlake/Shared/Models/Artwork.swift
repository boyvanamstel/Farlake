//
//  Artwork.swift
//  Farlake
//
//  Created by Boy van Amstel on 04/07/2020.
//  Copyright © 2020 Boy van Amstel. All rights reserved.
//

import UIKit

struct Artwork: Hashable {
    let id: String
    let title: String
    let image: UIImage?
}

extension Artwork {
    init(item: Collection.Item) {
        self.id = item.id
        self.title = item.title
        self.image = nil
    }
}
