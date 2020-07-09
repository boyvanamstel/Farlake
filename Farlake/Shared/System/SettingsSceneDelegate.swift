//
//  SettingsSceneDelegate.swift
//  Farlake
//
//  Created by Boy van Amstel on 09/07/2020.
//  Copyright © 2020 Boy van Amstel. All rights reserved.
//

import UIKit

#if targetEnvironment(macCatalyst)
class SettingsSceneDelegate: UIResponder, UIWindowSceneDelegate {

    var window: UIWindow?

    private var settingsCoordinator: CatalystSettingsCoordinator?

    func scene(_ scene: UIScene, willConnectTo session: UISceneSession, options connectionOptions: UIScene.ConnectionOptions) {
        // Prevent unexpected state by crashing when the window scene is not set
        guard let windowScene = scene as? UIWindowScene else { fatalError("Failed to get scene") }

        let window = UIWindow(windowScene: windowScene)
        self.window = window

        launchSettings(with: windowScene)
    }

    private func launchSettings(with windowScene: UIWindowScene) {
        settingsCoordinator = CatalystSettingsCoordinator(
            windowScene: windowScene,
            servicesProvider: ServicesProvider.default
        )
        settingsCoordinator?.start()
    }

}
#endif
