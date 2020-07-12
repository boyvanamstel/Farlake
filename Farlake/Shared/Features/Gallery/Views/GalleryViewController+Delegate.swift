//
//  GalleryViewController+Delegate.swift
//  Farlake
//
//  Created by Boy van Amstel on 12/07/2020.
//  Copyright © 2020 Boy van Amstel. All rights reserved.
//

import UIKit

// MARK: - UICollectionViewDelegate

extension GalleryViewController {
    private func detailViewController(for indexPath: IndexPath) -> UIViewController? {
        let artwork = self.dataSource.snapshot()
            .itemIdentifiers(inSection: .main)[indexPath.item]

        guard let viewModel = self.viewModel?.contentMenuViewModel(for: artwork) else { return nil }

        return GalleryItemDetailViewController(viewModel: viewModel)
    }

    override func collectionView(_ collectionView: UICollectionView,
                                 contextMenuConfigurationForItemAt indexPath: IndexPath,
                                 point: CGPoint) -> UIContextMenuConfiguration? {
        return UIContextMenuConfiguration(identifier: nil, previewProvider: {
            return self.detailViewController(for: indexPath)
        }, actionProvider: nil)
    }

    override func collectionView(_ collectionView: UICollectionView, shouldSelectItemAt indexPath: IndexPath) -> Bool {
        guard let viewController = detailViewController(for: indexPath) else { return false }

        delegate?.presentDetail(viewController: viewController)

        // We don't items to become actually selected
        return false
    }
}
