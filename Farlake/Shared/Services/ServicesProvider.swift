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
    let apiCache: URLCache
    let apiService: NetworkService

    let imageCache: URLCache
    let imageFetcher: NetworkService

    // Returns the default services provider, with a reasonable cache.
    static var `default`: Self {
        let apiCache = URLCache(
            memoryCapacity: NetworkConstants.apiCacheCapacity.memoryCapacity,
            diskCapacity: NetworkConstants.apiCacheCapacity.diskCapacity
        )
        let imageCache = URLCache(
            memoryCapacity: NetworkConstants.imageCacheCapacity.memoryCapacity,
            diskCapacity: NetworkConstants.imageCacheCapacity.diskCapacity
        )

        return Self.init(
            apiCache: apiCache,
            apiService: RijksmuseumNetworkService(urlCache: apiCache),
            imageCache: imageCache,
            imageFetcher: ImageFetcher(urlCache: imageCache)
        )
    }

    static var uiTesting: Self {
        return Self.init(
            apiCache: URLCache(),
            apiService: MockRijksmuseumNetworkService(),
            imageCache: URLCache(),
            imageFetcher: MockImageFetcher()
        )
    }

    required init(apiCache: URLCache, apiService: NetworkService, imageCache: URLCache, imageFetcher: NetworkService) {
        self.apiCache = apiCache
        self.apiService = apiService

        self.imageCache = imageCache
        self.imageFetcher = imageFetcher
    }
}
