//
//  Service.swift
//  Farlake
//
//  Created by Boy van Amstel on 06/07/2020.
//  Copyright © 2020 Boy van Amstel. All rights reserved.
//

import Foundation

protocol NetworkService {
    func load<Object>(_ resource: Resource<Object>, completion: @escaping (Object?) -> ()) -> URLSessionDataTask?
}

extension NetworkService {


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

class CachedNetworkService: NetworkService {

    private let cachedSession: URLSession

    init(urlCache: URLCache) {
        let configuration = URLSession.shared.configuration
        configuration.urlCache = urlCache

        cachedSession = URLSession(configuration: configuration)
    }

    // MARK: - Resource loading

    func load<Object>(_ resource: Resource<Object>, completion: @escaping (Object?) -> ()) -> URLSessionDataTask? {
        cachedSession.load(resource, completion: completion)
    }

}
