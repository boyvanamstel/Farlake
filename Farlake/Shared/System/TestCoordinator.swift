//
//  TestCoordinator.swift
//  Farlake
//
//  Created by Boy van Amstel on 04/07/2020.
//  Copyright © 2020 Boy van Amstel. All rights reserved.
//

import UIKit

#if DEBUG
/// Coordinates the app while running UI Tests.
final class TestCoordinator: Coordinator {

    var childCoordinators = [Coordinator]()
    weak var delegate: CoordinatorDelegate?

    /// Views or states to load directly.
    enum EntryPoint: String {
        case gallery, galleryDetail
    }

    private let window: UIWindow
    private let entryPoint: EntryPoint
    private let servicesProvider: ServicesProvider

    /// Instantiate the test coordinator.
    /// - Parameters:
    ///   - window: The root window.
    ///   - entryPoint: The view or state to load directly.
    ///   - servicesProvider: Injected dependencies.
    init(window: UIWindow, entryPoint: EntryPoint, servicesProvider: ServicesProvider) {
        self.window = window
        self.entryPoint = entryPoint
        self.servicesProvider = servicesProvider
    }

    /// Launch specified entry point.
    func start() {
        window.rootViewController = UIViewController()
        window.makeKeyAndVisible()

        // Show view based on entry point
        switch entryPoint {
        case .gallery: showGallery()
        case .galleryDetail: showGalleryDetail()
        }
    }

    // MARK: - Views

    private func showGallery() {
        let viewController = GalleryViewController(collectionViewLayout: .galleryLayout)
        let viewModel = GalleryViewModel(servicesProvider: servicesProvider)
        viewController.viewModel = viewModel

        window.rootViewController = viewController
    }

    private func showGalleryDetail() {
        let artwork = Artwork(guid: "guid",
                              title: "Title 1",
                              imageURL: URL(string: "https://www.example.com/1.jpg")!)
        let viewModel = GalleryItemDetailViewModel(artwork: artwork, servicesProvider: servicesProvider)
        let viewController = GalleryItemDetailViewController(viewModel: viewModel)

        window.rootViewController = viewController
    }

}

extension TestCoordinator: SceneCoordinating {
    func willEnterForeground() {}
    func didEnterBackground() {}
}
#endif
