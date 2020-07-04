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

        collectionView.accessibilityLabel = "Gallery"
    }

    // MARK: - Data source

    enum Section {
      case main
    }

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

    typealias SnapShot = NSDiffableDataSourceSnapshot<Section, Artwork>

    func update(items: [Artwork], withAnimation: Bool) {
        var snapshot = SnapShot()
        snapshot.appendSections([.main])
        snapshot.appendItems(items)
        dataSource.apply(snapshot, animatingDifferences: withAnimation, completion: nil)
    }

}
