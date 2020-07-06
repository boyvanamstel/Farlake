//
//  RijksmuseumNetworkService.swift
//  Farlake
//
//  Created by Boy van Amstel on 06/07/2020.
//  Copyright © 2020 Boy van Amstel. All rights reserved.
//

import Foundation

struct RijksMuseumEndpoint {
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

class RijksMuseumNetworkService: CachingNetworkService {
    let cachingSession: URLSession

    required init(urlCache: URLCache) {
        let configuration = URLSession.shared.configuration
        configuration.urlCache = urlCache

        cachingSession = URLSession(configuration: configuration)
    }
}
