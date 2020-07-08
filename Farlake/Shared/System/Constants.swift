//
//  Constants.swift
//  Farlake
//
//  Created by Boy van Amstel on 08/07/2020.
//  Copyright © 2020 Boy van Amstel. All rights reserved.
//

import UIKit

extension CGSize {
    static let galleryThumbnailSize = Self(equal: 200.0)
}

extension Int {
    static let maximumThumbnailCacheEntryCount = 250
}

extension String {
    static let thumbnailCacheName = "ThumbnailData"
}

extension CodingUserInfoKey {
    static let maximumCacheEntryCount = CodingUserInfoKey(rawValue: "MaximumCacheEntryCount")!
}
