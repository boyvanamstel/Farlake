//
//  GalleryViewController+DataSource.swift
//  Farlake
//
//  Created by Boy van Amstel on 12/07/2020.
//  Copyright © 2020 Boy van Amstel. All rights reserved.
//

import UIKit

extension GalleryViewController {

    /// Setup the diffable data source.
    func makeDataSource() -> DataSource {
        return DataSource(collectionView: collectionView) { collectionView, indexPath, artwork in

            let cell = collectionView.dequeueReusableCell(
                withReuseIdentifier: GalleryCollectionViewCell.reuseIdentifier,
                for: indexPath) as? GalleryCollectionViewCell

            cell?.viewModel = self.viewModel?.cellViewModel(for: artwork)

            return cell
        }
    }

    // MARK: Snapshot

    typealias SnapShot = NSDiffableDataSourceSnapshot<Section, Artwork>

    /// Use the diffable data source to automatically insert and remove items.
    /// - Parameters:
    ///   - items: The items to insert.
    ///   - withAnimation: Whether to use an animation.
    func append(items: [Artwork], withAnimation: Bool) {
        var snapshot = SnapShot()
        snapshot.appendSections([.main])
        snapshot.appendItems(items)

        dataSource.apply(snapshot, animatingDifferences: withAnimation)
    }
}
