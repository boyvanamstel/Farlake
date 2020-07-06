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

protocol CachingNetworkService: NetworkService {
    var cachingSession: URLSession { get }

    init(urlCache: URLCache)
}

extension CachingNetworkService {
    func load<Object>(_ resource: Resource<Object>, completion: @escaping (Object?) -> ()) -> URLSessionDataTask? {
        cachingSession.load(resource, completion: completion)
    }
}
