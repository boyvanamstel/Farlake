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

    #if targetEnvironment(macCatalyst)
    static let mainWindowMinimumSize = CGSize(width: 640.0, height: 768.0)
    static let settingsWindowMinimumSize = CGSize(width: 512.0, height: 768.0)
    #endif
}

extension Int {
    static let maximumThumbnailCacheEntryCount = 250
}

extension String {
    static let thumbnailCacheName = "ThumbnailData"

    static let galleryQuery = "Johannes Vermeer"
}

extension CodingUserInfoKey {
    static let maximumCacheEntryCount = CodingUserInfoKey(rawValue: "MaximumCacheEntryCount")!
}

extension NSUserActivity {
    static let settingsActivity = NSUserActivity(activityType: "Settings")
}
