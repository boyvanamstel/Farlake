//
//  Collection.swift
//  Farlake
//
//  Created by Boy van Amstel on 06/07/2020.
//  Copyright © 2020 Boy van Amstel. All rights reserved.
//

import Foundation

struct Collection: Decodable {
    let artObjects: [ArtObject]
}

struct ArtObject: Decodable {
    struct WebImage: Decodable {
        let url: URL?
    }

    let hasImage: Bool
    let webImage: WebImage
}
