//
//  URLRequest+Helpers.swift
//  Farlake
//
//  Created by Boy van Amstel on 07/07/2020.
//  Copyright © 2020 Boy van Amstel. All rights reserved.
//

import Foundation

typealias URLRequestParameters = [String: CustomStringConvertible]

extension URLRequest {

    /// Creates a new `URLRequest` with the parameters applied.
    /// - Parameters:
    ///   - url: The `URL` to apply parameters to.
    ///   - parameters: The parameters to apply to the `url`.
    init?(url: URL, parameters: URLRequestParameters) {
        guard var components = URLComponents(url: url, resolvingAgainstBaseURL: false) else {
            return nil
        }
        components.queryItems = parameters.keys
            .map { URLQueryItem(name: $0, value: parameters[$0]?.description) }
            .sorted { $0.name < $1.name } // Sort to ensure caching works

        guard let url = components.url else {
            return nil
        }

        self.init(url: url)
    }

}
