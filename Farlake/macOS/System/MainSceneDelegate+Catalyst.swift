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

    @objc private func refreshButtonTapped(_ sender: UIButton) {
        // Use the responder chain to find a view that can handle the action
        UIApplication.shared.sendAction(#selector(GalleryRefreshableAction.refreshGallery), to: nil, from: sender, for: nil)
    }

    func configureWindowSize(width windowScene: UIWindowScene) {
        windowScene.sizeRestrictions?.minimumSize = .mainWindowMinimumSize
    }
}

extension MainSceneDelegate: NSToolbarDelegate {
    func toolbarDefaultItemIdentifiers(_ toolbar: NSToolbar) -> [NSToolbarItem.Identifier] {
        return [.flexibleSpace, .refreshButtonIdentifier]
    }

    func toolbar(_ toolbar: NSToolbar, itemForItemIdentifier itemIdentifier: NSToolbarItem.Identifier, willBeInsertedIntoToolbar flag: Bool) -> NSToolbarItem? {
        switch itemIdentifier {
        case .refreshButtonIdentifier:
            let barButtonItem = UIBarButtonItem(image: UIImage(systemName: "arrow.clockwise"), style: .plain, target: self, action: #selector(self.refreshButtonTapped(_:)))
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
