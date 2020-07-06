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

    // MARK: - Bindings

    @Published var items = [Artwork]()

    // MARK: - Object lifecycle

    init(servicesProvider: ServicesProvider) {
        self.servicesProvider = servicesProvider
    }

    func viewDidLoad() {
        updateItems()
    }

    // MARK: - Item fetching

    func updateItems() {
        let resource = try! RijksmuseumEndpoint.collection(query: "Johannes Vermeer")
        fetch(resource: resource)
    }

    private func fetch(resource: Resource<Collection>) {
        _ = networkService.load(resource) { [weak self] collection in
            let artworks: [Artwork]? = collection?.items.compactMap { .init(item: $0) }

            self?.items = artworks ?? []
        }
    }

    // MARK: - Artwork

    func cellViewModel(for artwork: Artwork) -> GalleryCollectionViewCellViewModel {
        return GalleryCollectionViewCellViewModel(artwork: artwork, servicesProvider: servicesProvider)
    }

}
