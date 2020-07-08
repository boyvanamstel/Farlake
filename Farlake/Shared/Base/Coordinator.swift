//
//  Coordinator.swift
//  Farlake
//
//  Created by Boy van Amstel on 04/07/2020.
//  Copyright © 2020 Boy van Amstel. All rights reserved.
//

import Foundation

protocol CoordinatorDelegate {
    func didFinish(from coordinator: Coordinator)
}

protocol Coordinator: AnyObject {
    var childCoordinators: [Coordinator] { get set }
    var delegate: CoordinatorDelegate? { get set }

    func start()

    func addChildCoordinator(_ coordinator: Coordinator)
    func removeChildCoordinator(_ coordinator: Coordinator)
}

extension Coordinator {
    func addChildCoordinator(_ coordinator: Coordinator) {
        childCoordinators.append(coordinator)
    }

    func removeChildCoordinator(_ coordinator: Coordinator) {
        childCoordinators = childCoordinators.filter { $0 !== coordinator }
    }
}

// MARK: - Scene

protocol SceneCoordinating {
    func willEnterForeground()
    func didEnterBackground()
}
