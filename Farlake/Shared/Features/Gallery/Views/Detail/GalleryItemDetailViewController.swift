//
//  GalleryItemDetailViewController.swift
//  Farlake
//
//  Created by Boy van Amstel on 12/07/2020.
//  Copyright © 2020 Boy van Amstel. All rights reserved.
//

import UIKit
import Combine

class GalleryItemDetailViewController: UIViewController {

    // MARK: - Properties

    private let viewModel: GalleryItemDetailViewModel

    // MARK: - Object lifecycle

    init(viewModel: GalleryItemDetailViewModel) {
        self.viewModel = viewModel

        super.init(nibName: nil, bundle: nil)

        configureBindings()
    }

    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }

    override func loadView() {
        super.loadView()

        layoutElements()

        view.backgroundColor = .black
    }

    // MARK: - Bindings

    private var cancelBag = Set<AnyCancellable>()

    private func configureBindings() {
        viewModel.$image
            .receive(on: DispatchQueue.main)
            .sink { [weak self] image in
                guard let image = image else { return }

                self?.imageView.image = image
                self?.preferredContentSize = image.size
                self?.loadingView.stopAnimating()
                self?.loadingView.removeFromSuperview()
        }
        .store(in: &cancelBag)
    }

    // MARK: - Elements

    private lazy var titleField = with(UILabel()) {
        $0.translatesAutoresizingMaskIntoConstraints = false
        $0.numberOfLines = 0
        $0.textColor = .white

        $0.text = viewModel.title
    }

    private let titleContainerView = with(
    GradientView(colors: [UIColor.black.withAlphaComponent(0.0), UIColor.black.withAlphaComponent(0.6)])
    ) {
        $0.translatesAutoresizingMaskIntoConstraints = false
        $0.clipsToBounds = true
    }

    private let imageView = with(UIImageView()) {
        $0.translatesAutoresizingMaskIntoConstraints = false
        $0.clipsToBounds = true
        $0.contentMode = .scaleAspectFit
    }

    private let loadingView = with(UIActivityIndicatorView()) {
        $0.translatesAutoresizingMaskIntoConstraints = false
        $0.widthAnchor.constraint(equalToConstant: 64.0).isActive = true
        $0.heightAnchor.constraint(equalToConstant: 64.0).isActive = true

        $0.style = .large
        $0.color = .white

        $0.startAnimating()
    }

    // MARK: - Layout

    private func layoutElements() {
        view.addSubview(imageView)
        // Need to abstract this into convenience Auto Layout methods
        let layoutGuide = view.safeAreaLayoutGuide
        NSLayoutConstraint.activate([
            imageView.leadingAnchor.constraint(equalTo: layoutGuide.leadingAnchor),
            imageView.trailingAnchor.constraint(equalTo: layoutGuide.trailingAnchor),
            imageView.topAnchor.constraint(equalTo: layoutGuide.topAnchor),
            imageView.bottomAnchor.constraint(equalTo: layoutGuide.bottomAnchor)
        ])

        view.addSubview(titleContainerView)
            titleContainerView.pin(to: imageView, constraints: [
            equal(\.leadingAnchor),
            equal(\.trailingAnchor),
            equal(\.bottomAnchor)
        ])

        titleContainerView.addSubview(titleField)
        titleField.pin(to: titleContainerView, constraints: [
            equal(\.leadingAnchor, constant: 20.0),
            equal(\.trailingAnchor, constant: -20.0),
            equal(\.topAnchor, constant: 40.0),
            equal(\.bottomAnchor, constant: -20.0)
        ])

        view.addSubview(loadingView)
        loadingView.pin(to: view, constraints: [
            equal(\.centerXAnchor),
            equal(\.centerYAnchor)
        ])
    }

}

extension GalleryItemDetailViewController: NavigationReversableAction {
    @objc func popBack() {
        navigationController?.popViewController(animated: true)
    }
}
