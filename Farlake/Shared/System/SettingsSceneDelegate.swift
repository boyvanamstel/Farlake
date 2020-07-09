//
//  SettingsSceneDelegate.swift
//  Farlake
//
//  Created by Boy van Amstel on 09/07/2020.
//  Copyright © 2020 Boy van Amstel. All rights reserved.
//

import UIKit

class SettingsSceneDelegate: UIResponder, UIWindowSceneDelegate {

    var window: UIWindow?

    private var settingsCoordinator: CatalystSettingsCoordinator?

    func scene(_ scene: UIScene, willConnectTo session: UISceneSession, options connectionOptions: UIScene.ConnectionOptions) {
        // Prevent unexpected state by crashing when the window scene is not set
        guard let windowScene = scene as? UIWindowScene else { fatalError("Failed to get scene") }

        let window = UIWindow(windowScene: windowScene)
        self.window = window

        launchSettings(with: window)
    }

    private func launchSettings(with window: UIWindow) {
        settingsCoordinator = CatalystSettingsCoordinator(
            window: window,
            servicesProvider: ServicesProvider.default
        )
        settingsCoordinator?.start()
    }

}

