//
//  ServicesProvider.swift
//  Farlake
//
//  Created by Boy van Amstel on 06/07/2020.
//  Copyright © 2020 Boy van Amstel. All rights reserved.
//

import Foundation

/// Dependency container.
class ServicesProvider {
    let networkService: NetworkService

    // Returns the default services provider, with a reasonable cache.
    static var `default`: Self {
        let urlCache = URLCache(
            memoryCapacity: NetworkConstants.jsonCacheCapacity.memoryCapacity,
            diskCapacity: NetworkConstants.jsonCacheCapacity.diskCapacity
        )

        return Self.init(networkService: RijksMuseumNetworkService(urlCache: urlCache))
    }

    required init(networkService: NetworkService) {
        self.networkService = networkService
    }
}
