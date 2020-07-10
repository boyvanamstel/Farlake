//
//  RijksmuseumNetworkService.swift
//  Farlake
//
//  Created by Boy van Amstel on 06/07/2020.
//  Copyright © 2020 Boy van Amstel. All rights reserved.
//

import Foundation

extension Locale {
    /// Returns the current languageCode, defaulting to nl when nil
    var endpointLanguageCode: String { languageCode ?? "nl" }
}

struct RijksmuseumEndpoint {
    // swiftlint:disable identifier_name
    enum EndpointLocale: String {
        case en, nl
    }
    // swiftlint:enable identifier_name

    // swiftlint:disable line_length
    static let baseURL = URL(string: "https://www.rijksmuseum.nl/api/\(EndpointLocale(rawValue: Locale.current.endpointLanguageCode) ?? .nl)")!
    // swiftlint:enable line_length
    static let collectionURL = Self.baseURL.appendingPathComponent("collection")

    /// Create a collection resource based on the supplied query.
    /// - Parameters:
    ///   -  query: The keyword(s) to search for.
    ///   -  page: The page index to fetch.
    ///   -  itemsPerPage: The amount of items per page.
    /// - Parameter    /// - Throws: Throws `ResourceError` on invalid response.
    /// - Returns: Returns the fetchable resource.
    static func collection(query: String, page: Int = 0, itemsPerPage: Int = 100) throws -> Resource<Collection> {
        let url = Self.collectionURL
        let parameters: [String: CustomStringConvertible] = [
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

    private var collection: Collection {
        if CommandLine.arguments.contains("-test-gallery-empty") {
            return Collection.testEmpty
        }
        return Collection.testFull
    }

    func load<Object>(
        _ resource: Resource<Object>,
        completion: @escaping (Result<Object, Error>) -> Void
    ) -> URLSessionDataTask? {
        switch resource {
        case is Resource<Collection>:
            // swiftlint:disable force_cast
            completion(.success(self.collection as! Object))
            // swiftlint:enable force_cast
        default:
            break
        }

        return nil
    }
}
#endif
