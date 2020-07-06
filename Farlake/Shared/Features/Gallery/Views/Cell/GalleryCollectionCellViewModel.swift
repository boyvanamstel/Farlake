//
//  GalleryCollectionViewCellViewModel.swift
//  Farlake
//
//  Created by Boy van Amstel on 04/07/2020.
//  Copyright © 2020 Boy van Amstel. All rights reserved.
//

import UIKit

class GalleryCollectionViewCellViewModel {
    private let artwork: Artwork
    private let servicesProvider: ServicesProvider
    private var imageFetcher: NetworkService { servicesProvider.imageFetcher }

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
        dataTask = imageFetcher.load(resource) { [weak self] image in
            self?.image = image
        }
    }

}
