//
//  SceneDelegate+Catalyst.swift
//  Farlake
//
//  Created by Boy van Amstel on 09/07/2020.
//  Copyright © 2020 Boy van Amstel. All rights reserved.
//

import UIKit

#if targetEnvironment(macCatalyst)
extension NSToolbarItem.Identifier {
    static let backButtonIdentifier = NSToolbarItem.Identifier(rawValue: "BackButton")
    static let refreshButtonIdentifier = NSToolbarItem.Identifier(rawValue: "RefreshButton")
}

extension MainSceneDelegate {
    func configureTitleBar(with windowScene: UIWindowScene) {
        if let titlebar = windowScene.titlebar {
            let toolbar = NSToolbar(identifier: "MainToolbar")
            toolbar.delegate = self
            toolbar.allowsUserCustomization = false

            titlebar.titleVisibility = .hidden
            titlebar.toolbar = toolbar
        }
    }

    func configureWindowSize(width windowScene: UIWindowScene) {
        windowScene.sizeRestrictions?.minimumSize = .mainWindowMinimumSize
    }
}

extension MainSceneDelegate: NSToolbarDelegate {
    func toolbarDefaultItemIdentifiers(_ toolbar: NSToolbar) -> [NSToolbarItem.Identifier] {
        return [.backButtonIdentifier, .flexibleSpace, .refreshButtonIdentifier]
    }

    func toolbar(
        _ toolbar: NSToolbar,
        itemForItemIdentifier itemIdentifier: NSToolbarItem.Identifier,
        willBeInsertedIntoToolbar flag: Bool
    ) -> NSToolbarItem? {
        switch itemIdentifier {
        case .backButtonIdentifier:
            let barButtonItem = UIBarButtonItem(
                image: UIImage(systemName: "chevron.left")?
                    // Could use a more scientific way to determine size
                    .resize(using: .scaleAspectFit, in: CGRect(CGSize(width: 10.0, height: 12.0))),
                style: .plain,
                target: nil,
                action: #selector(NavigationReversableAction.popBack)
            )
            let button = NSToolbarItem(itemIdentifier: itemIdentifier, barButtonItem: barButtonItem)

            return button
        case .refreshButtonIdentifier:
            let barButtonItem = UIBarButtonItem(
                barButtonSystemItem: .refresh,
                target: nil,
                action: #selector(GalleryRefreshableAction.refreshGallery))
            let button = NSToolbarItem(itemIdentifier: itemIdentifier, barButtonItem: barButtonItem)

            return button
        default: return nil
        }
    }

    func toolbarAllowedItemIdentifiers(_ toolbar: NSToolbar) -> [NSToolbarItem.Identifier] {
        return toolbarDefaultItemIdentifiers(toolbar)
    }
}
#endif
