//
//  Collection.swift
//  Farlake
//
//  Created by Boy van Amstel on 06/07/2020.
//  Copyright © 2020 Boy van Amstel. All rights reserved.
//

import Foundation

struct Collection: Decodable {

    // MARK: - Collection

    let items: [Item]

    enum CodingKeys: String, CodingKey {
        case items = "artObjects"
    }

    // MARK: - Item

    struct Item: Decodable {
        let id: String

        let title: String
        let artist: String
        let isDownloadPermitted: Bool
        let image: Image?

        enum CodingKeys: String, CodingKey {
            case id
            case title
            case artist = "principalOrFirstMaker"
            case isDownloadPermitted = "permitDownload"
            case image = "webImage"
        }

        // MARK: - Image

        struct Image: Decodable {
            let width: Int
            let height: Int
            let url: URL

            enum CodingKeys: String, CodingKey {
                case width, height, url
            }

            init(from decoder: Decoder) throws {
                let values = try decoder.container(keyedBy: CodingKeys.self)
                width = try values.decode(Int.self, forKey: .width)
                height = try values.decode(Int.self, forKey: .height)

                // Parse string with url to proper `URL`
                let urlString = try values.decode(String.self, forKey: .url)
                guard let url = URL(string: urlString) else {
                    throw DecodingError.typeMismatch(URL.self, DecodingError.Context(codingPath: decoder.codingPath, debugDescription: "Failed to convert string into URL"))
                }
                self.url = url
            }

            #if DEBUG
            init(width: Int, height: Int, url: URL) {
                self.width = width
                self.height = height
                self.url = url
            }
            #endif
        }
    }
}
