//
//  GalleryCoordinator.swift
//  Farlake
//
//  Created by Boy van Amstel on 06/07/2020.
//  Copyright © 2020 Boy van Amstel. All rights reserved.
//

import UIKit

class GalleryCoordinator: Coordinator {

    var childCoordinators = [Coordinator]()
    var delegate: CoordinatorDelegate?

    private let navigationController: UINavigationController

    // MARK: - Object lifecycle

    init(navigationController: UINavigationController) {
        self.navigationController = navigationController
    }

    // MARK: - Entry point

    func start() {
        showGallery()
    }

    // MARK: - Views

    private func showGallery() {
        let viewController = GalleryViewController(collectionViewLayout: .galleryGridLayout)
        let viewModel = GalleryViewModel(items: [
            Artwork(title: "Square UP", image: UIImage(systemName: "arrow.up.square")!),
            Artwork(title: "Square RIGHT", image: UIImage(systemName: "arrow.right.square")!),
            Artwork(title: "Square DOWN", image: UIImage(systemName: "arrow.down.square")!),
            Artwork(title: "Square LEFT", image: UIImage(systemName: "arrow.left.square")!),
        ])
        viewController.viewModel = viewModel

        navigationController.setViewControllers([viewController], animated: true)
    }

}
