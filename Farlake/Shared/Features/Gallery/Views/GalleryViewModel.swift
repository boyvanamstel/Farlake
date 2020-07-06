//
//  GalleryViewModel.swift
//  Farlake
//
//  Created by Boy van Amstel on 04/07/2020.
//  Copyright © 2020 Boy van Amstel. All rights reserved.
//

import UIKit

class GalleryViewModel {
    private  let servicesProvider: ServicesProvider
    private var networkService: NetworkService { servicesProvider.networkService }

    @Published var items = [Artwork]()

    init(servicesProvider: ServicesProvider) {
        self.servicesProvider = servicesProvider
    }

    func viewDidLoad() {
        let resource = try! RijksmuseumEndpoint.collection(query: "Johannes Vermeer")

        _ = networkService.load(resource) { [weak self] collection in
            let artworks: [Artwork]? = collection?.items
                .compactMap { .init(item: $0) }

            self?.items = artworks ?? []
        }
    }
}
