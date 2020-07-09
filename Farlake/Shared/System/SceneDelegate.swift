//
//  SceneDelegate.swift
//  Farlake
//
//  Created by Boy van Amstel on 04/07/2020.
//  Copyright © 2020 Boy van Amstel. All rights reserved.
//

import UIKit

class SceneDelegate: UIResponder, UIWindowSceneDelegate {

    var window: UIWindow?

    private var sceneCoordinator: (Coordinator & SceneCoordinating)?

    func scene(_ scene: UIScene, willConnectTo session: UISceneSession, options connectionOptions: UIScene.ConnectionOptions) {
        // Prevent unexpected state by crashing when the window scene is not set
        guard let windowScene = scene as? UIWindowScene else { fatalError("Failed to get scene") }

        #if targetEnvironment(macCatalyst)
        configureTitleBar(with: windowScene)
        configureWindowSize(width: windowScene)
        #endif


        let window = UIWindow(windowScene: windowScene)
        self.window = window

        #if DEBUG
        if CommandLine.arguments.contains("-ui-testing") {
            uiTestApp(with: window)
            return
        }
        #endif

        launchApp(with: window)
    }

    private func launchApp(with window: UIWindow) {
        let navigationController = UINavigationController()

        sceneCoordinator = SceneCoordinator(
            navigationController: navigationController,
            window: window,
            servicesProvider: ServicesProvider.default
        )
        sceneCoordinator?.start()
    }

    #if DEBUG
    private func uiTestApp(with window: UIWindow) {
        // CommandLine.arguments are parsed into UserDefaults
        guard let entryPointString = UserDefaults.standard.string(forKey: "entry-point"),
            let entryPoint = TestCoordinator.EntryPoint(rawValue: entryPointString) else {
            fatalError("Did not specify UI Test entry point")
        }

        sceneCoordinator = TestCoordinator(
            window: window,
            entryPoint: entryPoint,
            servicesProvider: ServicesProvider.uiTesting
        )
        sceneCoordinator?.start()
    }
    #endif

    func sceneWillEnterForeground(_ scene: UIScene) {
        sceneCoordinator?.willEnterForeground()
    }

    func sceneDidEnterBackground(_ scene: UIScene) {
        // Also gets called when macOS target quits
        sceneCoordinator?.didEnterBackground()
    }

}
