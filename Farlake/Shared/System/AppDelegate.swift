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

    func application(_ application: UIApplication, didFinishLaunchingWithOptions launchOptions: [UIApplication.LaunchOptionsKey: Any]?) -> Bool {
        return true
    }

    // MARK: - UISceneSession lifecycle

    func application(_ application: UIApplication, configurationForConnecting connectingSceneSession: UISceneSession, options: UIScene.ConnectionOptions) -> UISceneConfiguration {
        if options.userActivities.first?.activityType == NSUserActivity.settingsActivity.activityType {
            return UISceneConfiguration(name: "Settings Configuration", sessionRole: connectingSceneSession.role)
        }
        return UISceneConfiguration(name: "Default Configuration", sessionRole: connectingSceneSession.role)
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
        let settingsMenu = UIMenu(title: settingsTitle, image: nil, identifier: UIMenu.Identifier("showPreferences"), options: .displayInline, children: [settingsCommand])
        builder.insertSibling(settingsMenu, afterMenu: .about)

        // Refresh
        let refreshCommand = UIKeyCommand(input: "R", modifierFlags: [.command], action: #selector(GalleryRefreshableAction.refreshGallery))
        let refreshTitle = NSLocalizedString("menu.refresh-gallery.title", comment: "The refresh gallery menu item title")
        refreshCommand.title = refreshTitle
        let reloadDataMenu = UIMenu(title: refreshTitle, image: nil, identifier: UIMenu.Identifier("refreshGallery"), options: .displayInline, children: [refreshCommand])
        builder.insertChild(reloadDataMenu, atStartOfMenu: .view)
    }

    @objc private func showSettings() {
        UIApplication.shared.requestSceneSessionActivation(nil, userActivity: .settingsActivity, options: nil, errorHandler: nil)
    }
}

