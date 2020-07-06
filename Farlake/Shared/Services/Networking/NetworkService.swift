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
