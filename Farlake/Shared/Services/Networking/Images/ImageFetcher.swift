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
    func loadThumbnail(_ resource: Resource<UIImage>, size: CGSize, completion: @escaping (UIImage?) -> ()) -> URLSessionDataTask?
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
    ///   - size: The size of the thumbnail.
    ///   - completion: Contains the loaded object.
    /// - Returns: The optional data task so it can be cancelled or stored.
    func loadThumbnail(_ resource: Resource<UIImage>, size: CGSize, completion: @escaping (UIImage?) -> ()) -> URLSessionDataTask? {
        // Unwrap url, because we need it a few times
        guard let url = resource.request.url else {
            completion(nil)
            return nil
        }

        // Return cached thumbnail if it exists
        let reference = ImageCacheKey(url: url, width: size.width, height: size.height)
        if let cachedImage = dataCache[reference] {
            completion(UIImage(data: cachedImage))
            return nil
        }

        return load(resource) { image in
            guard let image = image else {
                completion(nil)
                return
            }

            let thumbnail = image.resize(using: .scaleToFill, in: CGRect(size))
            let reference = ImageCacheKey(url: url, width: size.width, height: size.height)
            // Store thumbnail in cache
            if let data = thumbnail.jpegData(compressionQuality: 0.8) {
                self.dataCache.insert(data, forKey: reference)
            }

            completion(thumbnail)
        }
    }

}

#if DEBUG
class MockImageFetcher: NetworkService, ImageFetching {
    var session = URLSession.shared

    func loadThumbnail(_ resource: Resource<UIImage>, size: CGSize, completion: @escaping (UIImage?) -> ()) -> URLSessionDataTask? {
        return load(resource, completion: completion)
    }
}
#endif
