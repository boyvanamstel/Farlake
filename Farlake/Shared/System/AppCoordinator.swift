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

extension AppCoordinator: MainViewControllerDelegate {
    func didFinish() {
        showGallery()
    }
}

extension AppCoordinator: GalleryViewControllerDelegate {
}
