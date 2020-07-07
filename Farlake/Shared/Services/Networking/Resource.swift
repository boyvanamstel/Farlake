//
//  Resource.swift
//  Farlake
//
//  Created by Boy van Amstel on 06/07/2020.
//  Copyright © 2020 Boy van Amstel. All rights reserved.
//

import UIKit

// Based on Tiny Networking by Objc.io
// https://talk.objc.io/episodes/S01E133-tiny-networking-library-revisited

struct Resource<Object> {
    var request: URLRequest
    let parse: (Data) -> Object?
}

extension Resource where Object: Decodable {
    /// Creates a new resource for `Decodable` objects that can be parsed automatically.
    /// - Parameter request: The request to load a resource from.
    init(request: URLRequest) {
        self.request = request

        self.parse = { data in
            try? JSONDecoder().decode(Object.self, from: data)
        }
    }
}

extension Resource where Object: UIImage {
    /// Loads an image.
    /// - Parameter request: The request to load a resource from.
    init(request: URLRequest) {
        self.request = request

        self.parse = { data in
            Object(data: data)
        }
    }
}

enum ResourceError: Error {
    case invalidRequest
}
