//
//  GalleryViewContontroller.swift
//  Farlake
//
//  Created by Boy van Amstel on 04/07/2020.
//  Copyright © 2020 Boy van Amstel. All rights reserved.
//

import UIKit
import Combine

/// Contains the gallery collection view.
final class GalleryViewController: UICollectionViewController {

    var viewModel: GalleryViewModel? {
        didSet {
            configureBindings()
        }
    }

    // MARK: - Object lifecycle

    override func viewDidLoad() {
        super.viewDidLoad()

        configureCollectionView()

        viewModel?.viewDidLoad()
    }

    // MARK: - Bindings

    private var cancelBag: [AnyCancellable] = []

    private func configureBindings() {
        viewModel?.$items
            .receive(on: RunLoop.main)
            .sink(receiveValue: {
                self.update(items: $0, withAnimation: true)
            })
            .store(in: &cancelBag)
    }

    // MARK: - Collection view

    private lazy var refreshControl: UIRefreshControl = with(UIRefreshControl()) {
        $0.addTarget(self, action: #selector(updateItems(_:)), for: .valueChanged)
    }

    private func configureCollectionView() {
        collectionView.accessibilityLabel = "Gallery"

        collectionView.register(GalleryCollectionViewCell.self, forCellWithReuseIdentifier: GalleryCollectionViewCell.reuseIdentifier)

        collectionView.dataSource = dataSource

        collectionView.backgroundColor = .systemBackground

        collectionView.refreshControl = refreshControl
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

        refreshControl.endRefreshing()
    }

    // MARK: - Actions

    @objc private func updateItems(_ sender: UIRefreshControl) {
        viewModel?.updateItems()
    }

}
