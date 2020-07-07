//
//  ImageFetcher.swift
//  Farlake
//
//  Created by Boy van Amstel on 06/07/2020.
//  Copyright © 2020 Boy van Amstel. All rights reserved.
//

import UIKit

final class ImageFetcher: NetworkService, URLCaching {
    var session: URLSession

    let urlCache: URLCache

    init(urlCache: URLCache) {
        self.urlCache = urlCache

        let configuration: URLSessionConfiguration = .default
        configuration.requestCachePolicy = .returnCacheDataElseLoad
        configuration.urlCache = urlCache

        self.session = URLSession(configuration: configuration)
    }
}

#if DEBUG
class MockImageFetcher: NetworkService {
    var session = URLSession.shared
}
#endif
