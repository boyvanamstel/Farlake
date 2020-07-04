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

    private var appCoordinator: AppCoordinator?

    func scene(_ scene: UIScene, willConnectTo session: UISceneSession, options connectionOptions: UIScene.ConnectionOptions) {
        // Prevent unexpected state by crashing when the window scene is not set
        guard let windowScene = scene as? UIWindowScene else { fatalError("Failed to get scene") }

        let window = UIWindow(windowScene: windowScene)
        self.window = window

        #if DEBUG
        if CommandLine.arguments.contains("ui-testing") {
            uiTestApp(with: window)

            return
        }
        #endif

        launchApp(with: window)
    }

    private func launchApp(with window: UIWindow) {
        let navigationController = UINavigationController()

        // Create coordinator
        self.appCoordinator = AppCoordinator(navigationController: navigationController, window: window)

        appCoordinator?.start()
    }

    #if DEBUG
    private func uiTestApp(with window: UIWindow) {
        var viewController: UIViewController?

        if CommandLine.arguments.contains("nav-main") {
            viewController = UIStoryboard.instantiateMainViewController()
        } else if CommandLine.arguments.contains("nav-gallery") {
            viewController = UIStoryboard.instantiateGalleryViewController()
        }

        window.rootViewController = viewController
    }
    #endif

    func sceneDidDisconnect(_ scene: UIScene) {
        // Called as the scene is being released by the system.
        // This occurs shortly after the scene enters the background, or when its session is discarded.
        // Release any resources associated with this scene that can be re-created the next time the scene connects.
        // The scene may re-connect later, as its session was not neccessarily discarded (see `application:didDiscardSceneSessions` instead).
    }

    func sceneDidBecomeActive(_ scene: UIScene) {
        // Called when the scene has moved from an inactive state to an active state.
        // Use this method to restart any tasks that were paused (or not yet started) when the scene was inactive.
    }

    func sceneWillResignActive(_ scene: UIScene) {
        // Called when the scene will move from an active state to an inactive state.
        // This may occur due to temporary interruptions (ex. an incoming phone call).
    }

    func sceneWillEnterForeground(_ scene: UIScene) {
        // Called as the scene transitions from the background to the foreground.
        // Use this method to undo the changes made on entering the background.
    }

    func sceneDidEnterBackground(_ scene: UIScene) {
        // Called as the scene transitions from the foreground to the background.
        // Use this method to save data, release shared resources, and store enough scene-specific state information
        // to restore the scene back to its current state.
    }


}
