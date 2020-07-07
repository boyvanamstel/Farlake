//
//  ImageFetcher.swift
//  Farlake
//
//  Created by Boy van Amstel on 06/07/2020.
//  Copyright © 2020 Boy van Amstel. All rights reserved.
//

import UIKit

typealias ImageFetchingNetworkService = NetworkService & ImageFetching

protocol ImageFetching {
    func loadThumbnail(_ resource: Resource<UIImage>, completion: @escaping (UIImage?) -> ()) -> URLSessionDataTask?
}

final class ImageFetcher: NetworkService, URLCaching, ImageCaching {
    let urlCache: URLCache
    let dataCache: ImageDataCache

    var session: URLSession

    init(urlCache: URLCache, dataCache: ImageDataCache) {
        self.urlCache = urlCache
        self.dataCache = dataCache

        let configuration: URLSessionConfiguration = .default
        configuration.requestCachePolicy = .returnCacheDataElseLoad
        configuration.urlCache = urlCache

        self.session = URLSession(configuration: configuration)
    }
}

extension ImageFetcher: ImageFetching {
    /// Load an image from cache or URL and return in a closure.
    ///
    /// - Parameters:
    ///   - resource: The image resource to load.
    ///   - completion: Contains the loaded object.
    /// - Returns: The optional data task so it can be cancelled or stored.
    func loadThumbnail(_ resource: Resource<UIImage>, completion: @escaping (UIImage?) -> ()) -> URLSessionDataTask? {
        // Unwrap url, because we need it a few times
        guard let url = resource.request.url else {
            completion(nil)
            return nil
        }

        // Return cached thumbnail if it exists
        if let cachedImage = dataCache[url] {
            completion(cachedImage)
            return nil
        }

        return load(resource) { image in
            guard let image = image else {
                completion(nil)
                return
            }

            let thumbnail = image.resize(using: .scaleToFill, in: CGRect(CGSize(equal: 200.0)))

            // Store thumbnail in cache
            self.dataCache.insert(thumbnail, forKey: url)

            completion(thumbnail)
        }
    }

}

#if DEBUG
class MockImageFetcher: NetworkService, ImageFetching {
    var session = URLSession.shared

    func loadThumbnail(_ resource: Resource<UIImage>, completion: @escaping (UIImage?) -> ()) -> URLSessionDataTask? {
        return load(resource, completion: completion)
    }
}
#endif
