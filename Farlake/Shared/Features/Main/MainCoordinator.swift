//
//  MainCoordinator.swift
//  Farlake
//
//  Created by Boy van Amstel on 06/07/2020.
//  Copyright © 2020 Boy van Amstel. All rights reserved.
//

import UIKit

class MainCoordinator: Coordinator {

    var childCoordinators = [Coordinator]()
    var delegate: CoordinatorDelegate?

    private let navigationController: UINavigationController

    // MARK: - Object lifecycle

    init(navigationController: UINavigationController) {
        self.navigationController = navigationController
    }

    // MARK: - Entry point

    func start() {
        showMain()
    }

    // MARK: - Views

    private func showMain() {
        let viewController = UIStoryboard.instantiateMainViewController(delegate: self)

        navigationController.setViewControllers([viewController], animated: true)
    }

}

extension MainCoordinator: MainViewControllerDelegate {
    func didFinish() {
        delegate?.didFinish(from: self)
    }
}
