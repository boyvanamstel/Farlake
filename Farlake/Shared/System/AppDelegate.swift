//
//  AppDelegate.swift
//  Farlake
//
//  Created by Boy van Amstel on 04/07/2020.
//  Copyright © 2020 Boy van Amstel. All rights reserved.
//

import UIKit

@UIApplicationMain
class AppDelegate: UIResponder, UIApplicationDelegate {

    // MARK: - App dependencies

    private let defaultServicesProvider = ServicesProvider.createDefaultProvider()
    #if DEBUG
    private let uiTestServicesProvider = ServicesProvider.createUITestProvider()
    #endif

    private var servicesProvider: ServicesProvider {
        #if DEBUG
        if CommandLine.arguments.contains("-ui-testing") {
            return uiTestServicesProvider
        }
        #endif

        return defaultServicesProvider
    }

    // MARK: - App lifecycle

    func application(
        _ application: UIApplication,
        didFinishLaunchingWithOptions launchOptions: [UIApplication.LaunchOptionsKey: Any]?
    ) -> Bool {
        // Pass services provider to cached sessions
        application.openSessions.forEach { $0.servicesProvider = servicesProvider }

        return true
    }

    // MARK: - UISceneSession lifecycle

    func application(
        _ application: UIApplication,
        configurationForConnecting connectingSceneSession: UISceneSession,
        options: UIScene.ConnectionOptions
    ) -> UISceneConfiguration {
        // Pass depedencies
        connectingSceneSession.servicesProvider = servicesProvider

        if options.userActivities.first?.activityType == NSUserActivity.settingsActivity.activityType {
            return UISceneConfiguration(name: "Settings Configuration", sessionRole: connectingSceneSession.role)
        }
        return UISceneConfiguration(name: "Main Configuration", sessionRole: connectingSceneSession.role)
    }

    func application(_ application: UIApplication, didDiscardSceneSessions sceneSessions: Set<UISceneSession>) {
    }

    // MARK: - Menu

    override func buildMenu(with builder: UIMenuBuilder) {
        super.buildMenu(with: builder)

        // Preferences
        let settingsCommand = UIKeyCommand(input: ",", modifierFlags: [.command], action: #selector(showSettings))
        let settingsTitle = NSLocalizedString("menu.preferences.title", comment: "The preferences menu item title")
        settingsCommand.title = settingsTitle
        let settingsMenu = UIMenu(
            title: settingsTitle,
            image: nil,
            identifier: UIMenu.Identifier("showPreferences"),
            options: .displayInline,
            children: [settingsCommand]
        )
        builder.insertSibling(settingsMenu, afterMenu: .about)

        // Refresh
        let refreshCommand = UIKeyCommand(
            input: "R",
            modifierFlags: [.command],
            action: #selector(GalleryRefreshableAction.refreshGallery)
        )
        let refreshTitle = NSLocalizedString(
            "menu.refresh-gallery.title",
            comment: "The refresh gallery menu item title"
        )
        refreshCommand.title = refreshTitle
        let reloadDataMenu = UIMenu(
            title: refreshTitle,
            image: nil,
            identifier: UIMenu.Identifier("refreshGallery"),
            options: .displayInline,
            children: [refreshCommand]
        )
        builder.insertChild(reloadDataMenu, atStartOfMenu: .view)
    }

    @objc private func showSettings() {
        // Use the responder chain to find a view that can handle the action
        UIApplication.shared
            .sendAction(
                #selector(GallerySettingsPresentableAction.presentSettings),
                to: nil,
                from: self,
                for: nil
        )
    }
}
