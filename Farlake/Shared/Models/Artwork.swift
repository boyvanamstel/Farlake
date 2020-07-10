//
//  Artwork.swift
//  Farlake
//
//  Created by Boy van Amstel on 04/07/2020.
//  Copyright © 2020 Boy van Amstel. All rights reserved.
//

import UIKit

struct Artwork: Hashable {
    let guid: String
    let title: String
    let imageURL: URL?
}

extension Artwork {
    init(item: Collection.Item) {
        self.guid = item.guid
        self.title = item.title
        self.imageURL = item.image?.url
    }
}
