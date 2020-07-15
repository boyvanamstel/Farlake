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
        case ready
        case loading
        case error(Error)
    }

    private  let servicesProvider: ServicesProvider
    private var apiService: NetworkService { servicesProvider.apiService }

    private var dataTask: URLSessionDataTask?

    private var page = 1

    // MARK: - Bindings

    @Published var items = [Artwork]()
    @Published var state: State = .ready

    // MARK: - Object lifecycle

    init(servicesProvider: ServicesProvider) {
        self.servicesProvider = servicesProvider
    }

    func viewDidLoad() {
        fetchMoreItems()
    }

    // MARK: - Item fetching

    func updateItems() {
        page = 1
        guard case .ready = state,
            var resource = try? RijksmuseumEndpoint.collection(query: .galleryQuery, page: page) else { return }

        // Force to flush cache
        resource.request.cachePolicy = .reloadRevalidatingCacheData

        fetch(resource: resource)
    }

    func fetchMoreItems() {
        guard case .ready = state,
            let resource = try? RijksmuseumEndpoint.collection(query: .galleryQuery, page: page) else { return }

        fetch(resource: resource, append: true)
    }

    private func fetch(resource: Resource<Collection>, append: Bool = false) {
        state = .loading

        dataTask = apiService.load(resource) { [weak self] result in
            switch result {
            case .success(let collection):
                self?.page += 1 // Move to next page

                let items: [Artwork] = collection.items
                    .compactMap { .init(item: $0) }
                    .filter { artwork in
                        let hasImage = artwork.imageURL != nil
                        let isUnique = self?.items.first { $0.guid == artwork.guid } == nil

                        return hasImage && isUnique
                } // Filter items without image

                if append {
                    self?.items.append(contentsOf: items)
                } else {
                    self?.items = items
                }
                self?.state = .ready
            case .failure(let error):
                let nsError = error as NSError
                self?.state = nsError.code == NSURLErrorCancelled ? .ready : .error(error)
            }
        }
    }

    func cancelUpdate() {
        dataTask?.cancel()
    }

    // MARK: - Artwork

    func cellViewModel(for artwork: Artwork) -> GalleryCollectionViewCellViewModel {
        return GalleryCollectionViewCellViewModel(artwork: artwork, servicesProvider: servicesProvider)
    }

    func contentMenuViewModel(for artwork: Artwork) -> GalleryItemDetailViewModel {
        return GalleryItemDetailViewModel(artwork: artwork, servicesProvider: servicesProvider)
    }

}
