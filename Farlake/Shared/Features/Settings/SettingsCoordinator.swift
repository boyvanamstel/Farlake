//
//  SettingsCoordinator.swift
//  Farlake
//
//  Created by Boy van Amstel on 07/07/2020.
//  Copyright © 2020 Boy van Amstel. All rights reserved.
//

import SwiftUI

class SettingsCoordinator: Coordinator {

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
        showSettings()
    }

    // MARK: - Views

    private func showSettings() {
        let viewController = UIHostingController(rootView: SettingsView())
        viewController.modalPresentationStyle = .pageSheet

        navigationController.present(viewController, animated: true)
    }

}
