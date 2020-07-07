//
//  RijksmuseumNetworkService.swift
//  Farlake
//
//  Created by Boy van Amstel on 06/07/2020.
//  Copyright © 2020 Boy van Amstel. All rights reserved.
//

import Foundation

struct RijksmuseumEndpoint {
    /// Create a collection resource based on the supplied query.
    /// - Parameters:
    ///   -  query: The keyword(s) to search for.
    ///   -  page: The page index to fetch.
    ///   -  itemsPerPage: The amount of items per page.
    /// - Parameter    /// - Throws: Throws `ResourceError` on invalid response.
    /// - Returns: Returns the fetchable resource.
    static func collection(query: String, page: Int = 0, itemsPerPage: Int = 100) throws -> Resource<Collection> {
        let url = APIConstants.collectionURL
        let parameters: [String : CustomStringConvertible] = [
            "key": SecretConstants.apiKey,
            "q": query,
            "p": page,
            "ps": itemsPerPage
        ]
        guard let request = URLRequest(url: url, parameters: parameters) else {
            throw ResourceError.invalidRequest
        }

        return Resource<Collection>(request: request)
    }
}

class RijksmuseumNetworkService: NetworkService, URLCaching {
    let urlCache: URLCache
    let session: URLSession

    init(urlCache: URLCache) {
        self.urlCache = urlCache

        let configuration: URLSessionConfiguration = .default
        configuration.requestCachePolicy = .returnCacheDataElseLoad
        configuration.urlCache = urlCache

        self.session = URLSession(configuration: configuration)
    }
}

#if DEBUG
class MockRijksmuseumNetworkService: NetworkService {
    let session = URLSession.shared

    func load<Object>(_ resource: Resource<Object>, completion: @escaping (Object?) -> ()) -> URLSessionDataTask? {
        switch resource {
        case is Resource<Collection>:
            let collection = Collection(items: [
                Collection.Item(id: UUID().uuidString,
                                title: "Title 1",
                                artist: "Artist 1",
                                isDownloadPermitted: true,
                                image: Collection.Item.Image(width: 1024,
                                                             height: 768,
                                                             url: URL(string: "https://www.example.com/1.jpg")!)
                ),
                Collection.Item(id: UUID().uuidString,
                                title: "Title 2",
                                artist: "Artist 2",
                                isDownloadPermitted: true,
                                image: Collection.Item.Image(width: 640,
                                                             height: 480,
                                                             url: URL(string: "https://www.example.com/2.jpg")!)
                )
            ])
            completion(collection as? Object)
        default:
            break
        }

        return nil
    }
}
#endif
