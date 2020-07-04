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

    /// Views or states to load directly.
    enum EntryPoint: String {
        case main, gallery
    }

    private let window: UIWindow
    private let entryPoint: EntryPoint

    /// Instantiate the test coordinator.
    /// - Parameters:
    ///   - window: The root window.
    ///   - entryPoint: The view or state to load directly.
    init(window: UIWindow, entryPoint: EntryPoint) {
        self.window = window
        self.entryPoint = entryPoint
    }

    /// Launch specified entry point.
    func start() {
        window.rootViewController = UIViewController()
        window.makeKeyAndVisible()

        // Show view based on entry point
        switch entryPoint {
        case .main: showMain()
        case .gallery: showGallery()
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
