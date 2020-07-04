//
//  TestCoordinator.swift
//  Farlake
//
//  Created by Boy van Amstel on 04/07/2020.
//  Copyright © 2020 Boy van Amstel. All rights reserved.
//

import UIKit

/// Coordinates the app while running UI Tests.
final class TestCoordinator: Coordinator {

    private let window: UIWindow
    private let arguments: [String]

    /// Instantiate the test coordinator.
    /// - Parameters:
    ///   - window: The root window.
    init(window: UIWindow, arguments: [String]) {
        self.window = window
        self.arguments = arguments
    }

    /// Launch initial state of the app.
    func start() {
        window.rootViewController = UIViewController()
        window.makeKeyAndVisible()

        if CommandLine.arguments.contains("nav-main") {
            showMain()
        } else if CommandLine.arguments.contains("nav-gallery") {
            showGallery()
        }
    }

    // MARK: - Views

    private func showMain() {
        let viewController = UIStoryboard.instantiateMainViewController(delegate: self)
        window.rootViewController = viewController
    }

    private func showGallery() {
        let viewController = UIStoryboard.instantiateGalleryViewController(delegate: self)
        window.rootViewController = viewController
    }

}

extension TestCoordinator: MainViewControllerDelegate {
    func didFinish() {}
}

extension TestCoordinator: GalleryViewControllerDelegate {
}
