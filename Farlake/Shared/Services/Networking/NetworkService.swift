//
//  Service.swift
//  Farlake
//
//  Created by Boy van Amstel on 06/07/2020.
//  Copyright © 2020 Boy van Amstel. All rights reserved.
//

import Foundation

protocol NetworkService {
    var session: URLSession { get }

    func load<Object>(_ resource: Resource<Object>, completion: @escaping (Object?) -> ()) -> URLSessionDataTask?
}

extension NetworkService {
    /// Load a resource and return the parsed object(s) in a closure.
    ///
    /// - Parameters:
    ///   - resource: The resource to parse.
    ///   - completion: Contains the loaded object.
    /// - Returns: The optional data task so it can be cancelled or stored.
    func load<Object>(_ resource: Resource<Object>, completion: @escaping (Object?) -> ()) -> URLSessionDataTask? {
        let task = session.dataTask(with: resource.request) { data, response, _ in
            completion(data.flatMap(resource.parse))
        }
        task.resume()

        return task
    }
}

protocol URLCaching {
    var urlCache: URLCache { get }
}
