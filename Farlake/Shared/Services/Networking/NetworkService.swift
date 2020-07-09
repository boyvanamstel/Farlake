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

    func load<Object>(_ resource: Resource<Object>, completion: @escaping (Result<Object, Error>) -> ()) -> URLSessionDataTask?
}

extension NetworkService {
    /// Load a resource and return the parsed object(s) in a closure.
    ///
    /// - Parameters:
    ///   - resource: The resource to parse.
    ///   - completion: Contains the loaded object.
    /// - Returns: The optional data task so it can be cancelled or stored.
    func load<Object>(_ resource: Resource<Object>, completion: @escaping (Result<Object, Error>) -> ()) -> URLSessionDataTask? {
        let task = session.dataTask(with: resource.request) { data, response, error in
            // Error
            guard error == nil else {
                completion(.failure(error!))
                return
            }
            guard let httpResponse = response as? HTTPURLResponse else {
                completion(.failure(NetworkServiceError.unknownError))
                return
            }
            guard (200...399).contains(httpResponse.statusCode) else {
                completion(.failure(NetworkServiceError.unexpectedResponse))
                return
            }
            guard let object = data.flatMap(resource.parse) else {
                completion(.failure(NetworkServiceError.parseError))
                return
            }

            // Success
            completion(.success(object))
        }
        task.resume()

        return task
    }
}

enum NetworkServiceError: Error {
    case unknownError
    case unexpectedResponse
    case parseError

    var localizedDescription: String {
        switch self {
        case .unknownError: return NSLocalizedString("network-service-error.unknown", comment: "Unknown network service error.")
        case .unexpectedResponse: return NSLocalizedString("network-service-error.unexpected-response", comment: "The network service returned an unexpected response.")
        case .parseError: return NSLocalizedString("network-service-error.parse-error", comment: "The network service returned a response that couldn't be parsed.")
        }
    }
}
