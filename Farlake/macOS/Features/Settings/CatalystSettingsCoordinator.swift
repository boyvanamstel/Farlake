//
//  CatalystSettingsCoordinator.swift
//  Farlake
//
//  Created by Boy van Amstel on 09/07/2020.
//  Copyright © 2020 Boy van Amstel. All rights reserved.
//

import SwiftUI

#if targetEnvironment(macCatalyst)
class CatalystSettingsCoordinator: Coordinator {

    var childCoordinators = [Coordinator]()
    var delegate: CoordinatorDelegate?

    private let window: UIWindow
    private let servicesProvider: ServicesProvider

    // MARK: - Object lifecycle

    init(windowScene: UIWindowScene, servicesProvider: ServicesProvider) {
        windowScene.sizeRestrictions?.minimumSize = .settingsWindowMinimumSize

        self.window = UIWindow(windowScene: windowScene)
        self.servicesProvider = servicesProvider

        // Hide window title bar
        if let titlebar = windowScene.titlebar {
            titlebar.titleVisibility = .hidden
            titlebar.toolbar = nil
        }
    }

    // MARK: - Entry point

    func start() {
        window.makeKeyAndVisible()

        showSettings()
    }

    // MARK: - Views

    private func showSettings() {
        var view = SettingsView()
        view.viewModel = SettingsViewModel(servicesProvider: servicesProvider)
        let viewController = UIHostingController(rootView: view)

        window.rootViewController = viewController
    }

}
#endif
