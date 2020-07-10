//
//  SceneCoordinator.swift
//  Farlake
//
//  Created by Boy van Amstel on 04/07/2020.
//  Copyright © 2020 Boy van Amstel. All rights reserved.
//

import UIKit

final class MainSceneCoordinator: Coordinator {

    var childCoordinators = [Coordinator]()
    weak var delegate: CoordinatorDelegate?

    private let navigationController: UINavigationController
    private let window: UIWindow
    private let servicesProvider: ServicesProvider

    // MARK: - Object lifecycle

    /// Instantiate the application coordinator.
    /// - Parameters:
    ///   - navigationController: The root navigation controller.
    ///   - window: The root window.
    ///   - servicesProvider: Injected dependencies.
    init(navigationController: UINavigationController, window: UIWindow, servicesProvider: ServicesProvider) {
        self.navigationController = navigationController
        self.window = window
        self.servicesProvider = servicesProvider
    }

    // MARK: - Entry point

    /// Launch initial state of the app.
    func start() {
        window.rootViewController = navigationController
        window.makeKeyAndVisible()

        #if targetEnvironment(macCatalyst)
        navigationController.setNavigationBarHidden(true, animated: false)
        #endif

        showGallery()
    }

    // MARK: - Views

    private func showGallery() {
        let galleryCoordinator = GalleryCoordinator(
            navigationController: navigationController,
            servicesProvider: servicesProvider
        )
        galleryCoordinator.delegate = self
        addChildCoordinator(galleryCoordinator)

        galleryCoordinator.start()
    }

}

// MARK: - App state

extension MainSceneCoordinator: SceneCoordinating {
    func willEnterForeground() {}

    func didEnterBackground() {
        // Should log error to developer, don't inform user as it's not critical and could be confusing
        try? servicesProvider.imageDataCache.saveToDisk(withName: .thumbnailCacheName)
    }
}

// MARK: - Delegate

extension MainSceneCoordinator: CoordinatorDelegate {
    func didFinish(from coordinator: Coordinator) {

        switch coordinator {
        default:
            break
        }

        removeChildCoordinator(coordinator)
    }
}
