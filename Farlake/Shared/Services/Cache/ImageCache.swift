//
//  ImageCache.swift
//  Farlake
//
//  Created by Boy van Amstel on 08/07/2020.
//  Copyright © 2020 Boy van Amstel. All rights reserved.
//

import UIKit

// MARK: - Image cache

struct ImageCacheKey: Hashable, Codable {
    let url: URL

    // CGSize does not conform to Hashable
    let width: CGFloat
    let height: CGFloat
}

typealias ImageDataCache = Cache<ImageCacheKey, Data>

protocol ImageCaching {
    var dataCache: ImageDataCache { get }
}
