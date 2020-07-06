//
//  Collection.swift
//  Farlake
//
//  Created by Boy van Amstel on 06/07/2020.
//  Copyright © 2020 Boy van Amstel. All rights reserved.
//

import Foundation

struct Collection: Decodable {
    let artObjects: [ArtObject]
}

struct ArtObject: Decodable {
    struct WebImage: Decodable {
        let url: URL
    }

    let webImage: WebImage
}

extension Resource {

    /// Create a collection resource based on the supplied query.
    /// - Parameter query: The keyword(s) to search for.
    /// - Throws: Throws `ResourceError` on invalid response.
    /// - Returns: Returns the fetchable resource.
    static func collection(query: String) throws -> Resource<Collection> {
        let url = APIConstants.collectionURL
        let parameters: [String : CustomStringConvertible] = [
            "key": SecretConstants.apiKey,
            "q": query
            ]
        guard let request = URLRequest(url: url, parameters: parameters) else {
            throw ResourceError.invalidRequest
        }
        return Resource<Collection>(request: request)
    }

}
