//
//  GalleryViewContontroller.swift
//  Farlake
//
//  Created by Boy van Amstel on 04/07/2020.
//  Copyright © 2020 Boy van Amstel. All rights reserved.
//

import UIKit
import Combine

/// Can be added to a UIResponder that knows how to refresh the gallery.
@objc protocol GalleryRefreshableAction: AnyObject {
  func refreshGallery()
}
@objc protocol GallerySettingsPresentableAction: AnyObject {
  func presentSettings()
}

protocol GalleryViewControllerDelegate: AnyObject {
    func didRequestSettings()
}

/// Contains the gallery collection view.
final class GalleryViewController: UICollectionViewController {

    var viewModel: GalleryViewModel? {
        didSet {
            configureBindings()
        }
    }

    weak var delegate: GalleryViewControllerDelegate?

    // MARK: - Object lifecycle

    override func viewDidLoad() {
        super.viewDidLoad()

        configureCollectionView()
        configureNavigationBar()

        viewModel?.viewDidLoad()
    }

    // MARK: - Bindings

    private var cancelBag: [AnyCancellable] = []

    private func configureBindings() {
        viewModel?.$items
            .subscribe(on: DispatchQueue.global(qos: .userInitiated))
            .receive(on: DispatchQueue.main)
            .sink(receiveValue: {
                self.append(items: $0, withAnimation: true)
            })
            .store(in: &cancelBag)

        viewModel?.$state
            .receive(on: DispatchQueue.main)
            .sink(receiveValue: {
                switch $0 {
                case .idle: self.didBecomeIdle()
                case .loading: self.didStartLoading()
                case .ready: self.didBecomeReady()
                case .error(let error): self.present(error: error)
                }
            })
            .store(in: &cancelBag)
    }

    // MARK: - State

    private func didBecomeIdle() {
        refreshControl.endRefreshing()
    }

    private func didStartLoading() {
        refreshControl.beginRefreshing()
    }

    private func didBecomeReady() {
        refreshControl.endRefreshing()
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

    // MARK: - Navigation bar

    private func configureNavigationBar() {
        navigationController?.navigationBar.prefersLargeTitles = true

        navigationItem.title = .galleryQuery
        navigationItem.rightBarButtonItem = UIBarButtonItem(image: UIImage(systemName: "gear"), style: .plain, target: self, action: #selector(showSettings))
    }

    @objc private func showSettings() {
        delegate?.didRequestSettings()
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

            cell?.viewModel = self.viewModel?.cellViewModel(for: artwork)

            return cell
        }
    }

    // MARK: Snapshot

    typealias SnapShot = NSDiffableDataSourceSnapshot<Section, Artwork>

    /// Use the diffable data source to automatically insert and remove items.
    private func append(items: [Artwork], withAnimation: Bool) {
        var snapshot = SnapShot()
        snapshot.appendSections([.main])
        snapshot.appendItems(items)

        dataSource.apply(snapshot, animatingDifferences: withAnimation)
    }

    // MARK: - Actions

    @objc private func updateItems(_ sender: UIRefreshControl) {
        viewModel?.updateItems()
    }

    // MARK: - Error

    private func present(error: Error) {
        // Using an alert to make it fit in better on Catalyst
        let alert = UIAlertController(title: NSLocalizedString("gallery.network-service-error.alert.title", comment: "The network error alert title."), message: error.localizedDescription, preferredStyle: .alert)
        alert.addAction(UIAlertAction(title: NSLocalizedString("alert.retry.title", comment: "The retry button title."), style: .default) { _ in
            self.viewModel?.updateItems()
        })
        alert.addAction(UIAlertAction(title: NSLocalizedString("alert.cancel.title", comment: "The cancel button title."), style: .cancel) { _ in
            self.viewModel?.cancelUpdate()
        })

        present(alert, animated: true)
    }

}

extension GalleryViewController: GalleryRefreshableAction {
    @objc func refreshGallery() {
        viewModel?.updateItems()
    }
}

extension GalleryViewController: GallerySettingsPresentableAction {
    @objc func presentSettings() {
        showSettings()
    }
}
