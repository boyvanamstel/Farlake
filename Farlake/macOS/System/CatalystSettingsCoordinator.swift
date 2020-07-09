//
//  CatalystSettingsCoordinator.swift
//  Farlake
//
//  Created by Boy van Amstel on 09/07/2020.
//  Copyright © 2020 Boy van Amstel. All rights reserved.
//

import UIKit

class CatalystSettingsCoordinator: Coordinator {

    var childCoordinators = [Coordinator]()
    var delegate: CoordinatorDelegate?

    private let window: UIWindow
    private let servicesProvider: ServicesProvider

    // MARK: - Object lifecycle

    init(window: UIWindow, servicesProvider: ServicesProvider) {
        self.window = window
        self.servicesProvider = servicesProvider
    }

    // MARK: - Entry point

    func start() {
        window.makeKeyAndVisible()

        showSettings()
    }

    // MARK: - Views

    private func showSettings() {
        let viewController = UIStoryboard.instantiateSettingsViewController()

        window.rootViewController = viewController
    }

}
