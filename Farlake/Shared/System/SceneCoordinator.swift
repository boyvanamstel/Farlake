//
//  SceneCoordinator.swift
//  Farlake
//
//  Created by Boy van Amstel on 04/07/2020.
//  Copyright © 2020 Boy van Amstel. All rights reserved.
//

import UIKit

final class SceneCoordinator: Coordinator {

    var childCoordinators = [Coordinator]()
    var delegate: CoordinatorDelegate?

    private let navigationController: UINavigationController
    private let window: UIWindow

    // MARK: - Object lifecycle

    /// Instantiate the application coordinator.
    /// - Parameters:
    ///   - navigationController: The root navigation controller.
    ///   - window: The root window.
    init(navigationController: UINavigationController, window: UIWindow) {
        self.navigationController = navigationController
        self.window = window
    }

    // MARK: - Entry point

    /// Launch initial state of the app.
    func start() {
        window.rootViewController = navigationController
        window.makeKeyAndVisible()

        showMain()
    }

    // MARK: - Views

    private func showMain() {
        let mainCoordinator = MainCoordinator(navigationController: navigationController)
        mainCoordinator.delegate = self
        addChildCoordinator(mainCoordinator)

        mainCoordinator.start()
    }

    private func showGallery() {
        let galleryCoordinator = GalleryCoordinator(navigationController: navigationController)
        galleryCoordinator.delegate = self
        addChildCoordinator(galleryCoordinator)

        galleryCoordinator.start()
    }

}

extension SceneCoordinator: CoordinatorDelegate {
    func didFinish(from coordinator: Coordinator) {

        switch coordinator {
        case is MainCoordinator:
            showGallery()
        default:
            break
        }

        removeChildCoordinator(coordinator)
    }
}
