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
    let urlCache: URLCache
    let networkService: NetworkService
    let imageFetcher: NetworkService

    // Returns the default services provider, with a reasonable cache.
    static var `default`: Self {
        let urlCache = URLCache(
            memoryCapacity: NetworkConstants.jsonCacheCapacity.memoryCapacity,
            diskCapacity: NetworkConstants.jsonCacheCapacity.diskCapacity
        )

        return Self.init(
            urlCache: urlCache,
            networkService: RijksmuseumNetworkService(urlCache: urlCache),
            imageFetcher: ImageFetcher(urlCache: urlCache)
        )
    }

    static var uiTesting: Self {
        return Self.init(
            urlCache: URLCache(),
            networkService: MockRijksmuseumNetworkService(),
            imageFetcher: ImageFetcher(urlCache: URLCache())
        )
    }

    required init(urlCache: URLCache, networkService: NetworkService, imageFetcher: ImageFetcher) {
        self.urlCache = urlCache
        self.networkService = networkService
        self.imageFetcher = imageFetcher
    }
}
