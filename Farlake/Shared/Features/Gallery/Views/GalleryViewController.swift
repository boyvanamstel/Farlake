//
//  GalleryViewContontroller.swift
//  Farlake
//
//  Created by Boy van Amstel on 04/07/2020.
//  Copyright © 2020 Boy van Amstel. All rights reserved.
//

import UIKit

/// Contains the gallery collection view.
final class GalleryViewController: UICollectionViewController {

    var viewModel: GalleryViewModel? {
        didSet {
            update(items: viewModel?.items ?? [], withAnimation: true)
        }
    }

    // MARK: - Object lifecycle

    override func viewDidLoad() {
        super.viewDidLoad()

        configureCollectionView()
    }

    // MARK: - Collection view

    private func configureCollectionView() {
        collectionView.accessibilityLabel = "Gallery"

        collectionView.register(GalleryCollectionViewCell.self, forCellWithReuseIdentifier: GalleryCollectionViewCell.reuseIdentifier)

        collectionView.dataSource = dataSource

        collectionView.backgroundColor = .systemBackground
    }

    // MARK: - Content

    enum Section {
      case main
    }

    // MARK: Data source

    typealias DataSource = UICollectionViewDiffableDataSource<Section, Artwork>

    private lazy var dataSource = makeDataSource()

    /// Setup the diffable data source.
    private func makeDataSource() -> DataSource {
        return DataSource(collectionView: collectionView) { collectionView, indexPath, artwork in

            let cell = collectionView.dequeueReusableCell(
                withReuseIdentifier: GalleryCollectionViewCell.reuseIdentifier,
            for: indexPath) as? GalleryCollectionViewCell

            cell?.viewModel = GalleryCollectionViewCellViewModel(artwork: artwork)

            return cell
        }
    }

    // MARK: Snapshot

    typealias SnapShot = NSDiffableDataSourceSnapshot<Section, Artwork>

    /// Use the diffable data source to automatically insert and remove items.
    private func update(items: [Artwork], withAnimation: Bool) {
        var snapshot = SnapShot()
        snapshot.appendSections([.main])
        snapshot.appendItems(items)
        dataSource.apply(snapshot, animatingDifferences: withAnimation)
    }

}
