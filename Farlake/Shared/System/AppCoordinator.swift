//
//  MainCoordinator.swift
//  Farlake
//
//  Created by Boy van Amstel on 04/07/2020.
//  Copyright © 2020 Boy van Amstel. All rights reserved.
//

import UIKit

final class AppCoordinator: Coordinator {

    private let navigationController: UINavigationController
    private let window: UIWindow

    /// Instantiate the application coordinator.
    /// - Parameters:
    ///   - navigationController: The root navigation controller.
    ///   - window: The root window.
    init(navigationController: UINavigationController, window: UIWindow) {
        self.navigationController = navigationController
        self.window = window
    }

    /// Launch initial state of the app.
    func start() {
        window.rootViewController = navigationController
        window.makeKeyAndVisible()

        showMain()
    }

    // MARK: - Views

    private func showMain() {
        let viewController = UIStoryboard.instantiateMainViewController(delegate: self)
        navigationController.setViewControllers([viewController], animated: true)
    }

    private func showGallery() {
        let viewController = UIStoryboard.instantiateGalleryViewController(delegate: self)
        navigationController.setViewControllers([viewController], animated: true)
    }

}

extension AppCoordinator: MainViewControllerDelegate {
    func didFinish() {
        showGallery()
    }
}

extension AppCoordinator: GalleryViewControllerDelegate {
}
