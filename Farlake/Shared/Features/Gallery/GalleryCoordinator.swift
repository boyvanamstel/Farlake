//
//  GalleryCoordinator.swift
//  Farlake
//
//  Created by Boy van Amstel on 06/07/2020.
//  Copyright © 2020 Boy van Amstel. All rights reserved.
//

import UIKit

final class GalleryCoordinator: Coordinator {

    var childCoordinators = [Coordinator]()
    weak var delegate: CoordinatorDelegate?

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
        let viewController = GalleryViewController(collectionViewLayout: .galleryLayout)
        let viewModel = GalleryViewModel(servicesProvider: servicesProvider)
        viewController.viewModel = viewModel
        viewController.delegate = self

        navigationController.setViewControllers([viewController], animated: true)
    }

    func showSettings() {
        #if targetEnvironment(macCatalyst)
        UIApplication.shared
            .requestSceneSessionActivation(nil,
                userActivity: .settingsActivity,
                options: nil,
                errorHandler: nil)
        #else
        let settingsCoordinator = SettingsCoordinator(
            navigationController: navigationController,
            servicesProvider: servicesProvider
        )
        settingsCoordinator.delegate = self
        addChildCoordinator(settingsCoordinator)

        settingsCoordinator.start()
        #endif
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

extension GalleryCoordinator: GalleryViewControllerDelegate {
    func didRequestSettings() {
        showSettings()
    }
}
