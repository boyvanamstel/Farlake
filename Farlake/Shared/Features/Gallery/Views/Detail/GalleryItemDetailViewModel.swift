//
//  GalleryItemDetailViewModel.swift
//  Farlake
//
//  Created by Boy van Amstel on 12/07/2020.
//  Copyright © 2020 Boy van Amstel. All rights reserved.
//

import UIKit

class GalleryItemDetailViewModel {
    private let artwork: Artwork
    private let servicesProvider: ServicesProvider
    private var imageFetcher: ImageFetchingNetworkService { servicesProvider.imageFetcher }

    private var dataTask: URLSessionDataTask?

    // MARK: - Bindings

    @Published var image: UIImage?

    // MARK: - Object lifecycle

    init(artwork: Artwork, servicesProvider: ServicesProvider) {
        self.artwork = artwork
        self.servicesProvider = servicesProvider

        fetchImage()
    }

    deinit {
        dataTask?.cancel()
    }

    // MARK: - User facing Properties

    var title: String { artwork.title }

    // MARK: - Image fetching

    private func fetchImage() {
        guard let url = artwork.imageURL else { return }

        let request = URLRequest(url: url)
        let resource = Resource<UIImage>(request: request)
        dataTask = imageFetcher.load(resource) { [weak self] result in
            guard case .success(let image) = result else {
                self?.image = UIImage(systemName: "exclamationmark.triangle")?
                    .withTintColor(.black, renderingMode: .alwaysOriginal)
                return
            }
            self?.image = image
        }
    }

}
