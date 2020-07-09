//
//  GalleryViewModel.swift
//  Farlake
//
//  Created by Boy van Amstel on 04/07/2020.
//  Copyright © 2020 Boy van Amstel. All rights reserved.
//

import UIKit

class GalleryViewModel {
    enum State {
        case idle
        case loading
        case ready
        case error(Error)
    }

    private  let servicesProvider: ServicesProvider
    private var apiService: NetworkService { servicesProvider.apiService }

    // MARK: - Bindings

    @Published var items = [Artwork]()
    @Published var state: State = .idle

    // MARK: - Object lifecycle

    init(servicesProvider: ServicesProvider) {
        self.servicesProvider = servicesProvider
    }

    func viewDidLoad() {
        loadItems()
    }

    // MARK: - Item fetching

    private func loadItems() {
        let resource = try! RijksmuseumEndpoint.collection(query: "Johannes Vermeer")
        fetch(resource: resource)
    }

    func updateItems() {
        loadItems()
    }

    private func fetch(resource: Resource<Collection>) {
        state = .loading
        _ = apiService.load(resource) { [weak self] result in
            switch result {
            case .success(let collection):
                self?.items = collection.items
                    .compactMap { .init(item: $0) }
                    .filter { $0.imageURL != nil } // Filter items without image
                self?.state = .ready
            case .failure(let error):
                self?.state = .error(error)
            }
        }
    }

    // MARK: - Artwork

    func cellViewModel(for artwork: Artwork) -> GalleryCollectionViewCellViewModel {
        return GalleryCollectionViewCellViewModel(artwork: artwork, servicesProvider: servicesProvider)
    }

}
