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
    private func artwork(for indexPath: IndexPath) -> Artwork {
        return dataSource.snapshot().itemIdentifiers(inSection: .main)[indexPath.item]
    }

    override func collectionView(_ collectionView: UICollectionView,
                                 contextMenuConfigurationForItemAt indexPath: IndexPath,
                                 point: CGPoint) -> UIContextMenuConfiguration? {
        return UIContextMenuConfiguration(identifier: nil, previewProvider: {
            return self.delegate?.detailViewController(for: self.artwork(for: indexPath))
        }, actionProvider: nil)
    }

    override func collectionView(_ collectionView: UICollectionView,
                                 didSelectItemAt indexPath: IndexPath) {
        delegate?.presentDetail(for: artwork(for: indexPath))
    }

    override func collectionView(_ collectionView: UICollectionView,
                                 willDisplay cell: UICollectionViewCell,
                                 forItemAt indexPath: IndexPath) {
        let itemCount = collectionView.numberOfItems(inSection: Section.main.rawValue)
        guard indexPath.item == itemCount - 1 else { return }

        viewModel?.fetchMoreItems()
    }
}
