//
//  GalleryViewModel.swift
//  Farlake
//
//  Created by Boy van Amstel on 04/07/2020.
//  Copyright © 2020 Boy van Amstel. All rights reserved.
//

import UIKit

final class GalleryViewModel {
    enum State {
        case idle
        case loading
        case ready
        case error(Error)
    }

    private  let servicesProvider: ServicesProvider
    private var apiService: NetworkService { servicesProvider.apiService }

    private var dataTask: URLSessionDataTask?

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

    // swiftlint:disable force_try
    private let resource = try! RijksmuseumEndpoint.collection(query: .galleryQuery)
    // swiftlint:enable force_try

    private func loadItems() {
        fetch(resource: resource)
    }

    func updateItems() {
        var resource = self.resource
        // Force to flush cache
        resource.request.cachePolicy = .reloadRevalidatingCacheData

        fetch(resource: resource)
    }

    private func fetch(resource: Resource<Collection>) {
        state = .loading

        dataTask = apiService.load(resource) { [weak self] result in
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

    func cancelUpdate() {
        dataTask?.cancel()

        state = .idle
    }

    // MARK: - Artwork

    func cellViewModel(for artwork: Artwork) -> GalleryCollectionViewCellViewModel {
        return GalleryCollectionViewCellViewModel(artwork: artwork, servicesProvider: servicesProvider)
    }

    func contentMenuViewModel(for artwork: Artwork) -> GalleryContextMenuViewModel {
        return GalleryContextMenuViewModel(artwork: artwork, servicesProvider: servicesProvider)
    }

}
