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

    func showGallery() {
        let viewController = GalleryViewController(collectionViewLayout: .galleryGridLayout)
        let viewModel = GalleryViewModel(servicesProvider: servicesProvider)
        viewController.viewModel = viewModel
        viewController.coordinator = self

        navigationController.setViewControllers([viewController], animated: true)
    }

    func showSettings() {
        let settingsCoordinator = SettingsCoordinator(navigationController: navigationController, servicesProvider: servicesProvider)
        settingsCoordinator.delegate = self
        addChildCoordinator(settingsCoordinator)

        settingsCoordinator.start()
    }

}

extension GalleryCoordinator: CoordinatorDelegate {
    func didFinish(from coordinator: Coordinator) {

        switch coordinator {
        default:
            break
        }

        removeChildCoordinator(coordinator)
    }
}
