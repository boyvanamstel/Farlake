//
//  GalleryViewContontroller.swift
//  Farlake
//
//  Created by Boy van Amstel on 04/07/2020.
//  Copyright © 2020 Boy van Amstel. All rights reserved.
//

import UIKit

protocol GalleryViewControllerDelegate: AnyObject {}

/// Contains the gallery collection view.
final class GalleryViewController: UICollectionViewController {

    weak var delegate: GalleryViewControllerDelegate?

    var viewModel: GalleryViewModel? {
        didSet {
            update(items: viewModel?.items ?? [], withAnimation: true)
        }
    }

    override func viewDidLoad() {
        super.viewDidLoad()

        configureCollectionView()
    }

    // MARK: - Collection view

    private func configureCollectionView() {
        collectionView.accessibilityLabel = "Gallery"
        collectionView.collectionViewLayout = makeLayout()
    }

    private func makeLayout() -> UICollectionViewLayout {
        // Item
        let itemSize = NSCollectionLayoutSize(widthDimension: .fractionalWidth(0.5), heightDimension: .fractionalHeight(1.0))
        let item = NSCollectionLayoutItem(layoutSize: itemSize)
        item.contentInsets = NSDirectionalEdgeInsets(equal: 5.0)

        // Group
        let groupSize = NSCollectionLayoutSize(widthDimension: .fractionalWidth(1.0), heightDimension: .fractionalWidth(0.5))
        let group = NSCollectionLayoutGroup.horizontal(layoutSize: groupSize, subitems: [item])

        // Section
        let section = NSCollectionLayoutSection(group: group)

        return UICollectionViewCompositionalLayout(section: section)
    }

    // MARK: - Content

    enum Section {
      case main
    }

    // MARK: Data source

    typealias DataSource = UICollectionViewDiffableDataSource<Section, Artwork>
    private lazy var dataSource = makeDataSource()

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

    func update(items: [Artwork], withAnimation: Bool) {
        var snapshot = SnapShot()
        snapshot.appendSections([.main])
        snapshot.appendItems(items)
        dataSource.apply(snapshot, animatingDifferences: withAnimation)
    }

}
