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

    let imageURLCache: URLCache
    let imageDataCache: ImageDataCache
    let imageFetcher: ImageFetchingNetworkService

    // Returns the default services provider, with a reasonable cache.
    static var `default`: Self {
        let apiCache = URLCache(
            memoryCapacity: NetworkConstants.apiCacheCapacity.memoryCapacity,
            diskCapacity: NetworkConstants.apiCacheCapacity.diskCapacity
        )

        let imageURLCache = URLCache(
            memoryCapacity: NetworkConstants.imageCacheCapacity.memoryCapacity,
            diskCapacity: NetworkConstants.imageCacheCapacity.diskCapacity
        )

        let imageCacheDecoder = JSONDecoder()
        imageCacheDecoder.userInfo = [.maximumCacheEntryCount: Int.maximumThumbnailCacheEntryCount]
        let imageDataCache = (try? ImageDataCache.loadFromDisk(withName: .thumbnailCacheName, decoder: imageCacheDecoder)) ?? ImageDataCache(maximumEntryCount: .maximumThumbnailCacheEntryCount)

        return Self.init(
            apiCache: apiCache,
            apiService: RijksmuseumNetworkService(urlCache: apiCache),
            imageURLCache: imageURLCache,
            imageDataCache: imageDataCache,
            imageFetcher: ImageFetcher(urlCache: imageURLCache, dataCache: imageDataCache)
        )
    }

    static var uiTesting: Self {
        return Self.init(
            apiCache: URLCache(),
            apiService: MockRijksmuseumNetworkService(),
            imageURLCache: URLCache(),
            imageDataCache: ImageDataCache(),
            imageFetcher: MockImageFetcher()
        )
    }

    required init(apiCache: URLCache, apiService: NetworkService, imageURLCache: URLCache, imageDataCache: ImageDataCache, imageFetcher: ImageFetchingNetworkService) {
        self.apiCache = apiCache
        self.apiService = apiService

        self.imageURLCache = imageURLCache
        self.imageDataCache = imageDataCache
        self.imageFetcher = imageFetcher
    }
}
