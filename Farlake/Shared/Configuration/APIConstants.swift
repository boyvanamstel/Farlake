//
//  APIConstants.swift
//  Farlake
//
//  Created by Boy van Amstel on 06/07/2020.
//  Copyright © 2020 Boy van Amstel. All rights reserved.
//

import Foundation

struct APIConstants {
    static let baseURL = URL(string: "https://www.rijksmuseum.nl/api/nl")!
    static let collectionURL = Self.baseURL.appendingPathComponent("collection")
}
