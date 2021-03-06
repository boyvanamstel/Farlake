//
//  SettingsCoordinator.swift
//  Farlake
//
//  Created by Boy van Amstel on 07/07/2020.
//  Copyright © 2020 Boy van Amstel. All rights reserved.
//

import SwiftUI

final class SettingsCoordinator: Coordinator {

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
        showSettings()
    }

    // MARK: - Views

    private func showSettings() {
        var view = SettingsView()
        view.viewModel = SettingsViewModel(servicesProvider: servicesProvider)
        let viewController = UIHostingController(rootView: view)
        viewController.modalPresentationStyle = .pageSheet

        navigationController.present(viewController, animated: true)
    }

}
