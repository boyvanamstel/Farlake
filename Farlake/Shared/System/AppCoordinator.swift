//
//  MainCoordinator.swift
//  Farlake
//
//  Created by Boy van Amstel on 04/07/2020.
//  Copyright © 2020 Boy van Amstel. All rights reserved.
//

import UIKit

final class AppCoordinator {

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
      let mainViewController = UIStoryboard(name: "Main", bundle: nil).instantiateViewController(withIdentifier: "mainViewController") as! MainViewController
      navigationController.setViewControllers([mainViewController], animated: true)
    }

}
