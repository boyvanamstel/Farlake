//
//  NetworkConstants.swift
//  Farlake
//
//  Created by Boy van Amstel on 06/07/2020.
//  Copyright © 2020 Boy van Amstel. All rights reserved.
//

import Foundation

// Convenience constant for converting to MBs
private let MB = 1024 * 1024

struct NetworkConstants {
    struct CacheCapacity {
        let memoryCapacity: Int
        let diskCapacity: Int
    }

    static let apiCacheCapacity = CacheCapacity(memoryCapacity: 100 * MB, diskCapacity: 100 * MB)
    static let imageCacheCapacity = CacheCapacity(memoryCapacity: 512 * MB, diskCapacity: 1024 * MB)
}
