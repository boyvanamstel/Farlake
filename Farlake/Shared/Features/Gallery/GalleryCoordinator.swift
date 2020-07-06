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
    private let servicesProvider: ServicesProvider

    // MARK: - Object lifecycle

    init(navigationController: UINavigationController, servicesProvider: ServicesProvider) {
        self.navigationController = navigationController
        self.servicesProvider = servicesProvider
    }

    // MARK: - Entry point

    func start() {
        showGallery()
    }

    // MARK: - Views

    private func showGallery() {
        let viewController = GalleryViewController(collectionViewLayout: .galleryGridLayout)
        let viewModel = GalleryViewModel(servicesProvider: servicesProvider)
        viewController.viewModel = viewModel

        navigationController.setViewControllers([viewController], animated: true)
    }

}
