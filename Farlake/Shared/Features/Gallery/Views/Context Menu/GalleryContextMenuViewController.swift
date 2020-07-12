//
//  GalleryContextMenuViewController.swift
//  Farlake
//
//  Created by Boy van Amstel on 12/07/2020.
//  Copyright © 2020 Boy van Amstel. All rights reserved.
//

import UIKit
import Combine

class GalleryContextMenuViewController: UIViewController {

    // MARK: - Properties

    private let viewModel: GalleryContextMenuViewModel

    // MARK: - Object lifecycle

    init(viewModel: GalleryContextMenuViewModel) {
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
    }

    // MARK: - Bindings

    private var cancelBag = Set<AnyCancellable>()

    private func configureBindings() {
        viewModel.$image
            .receive(on: DispatchQueue.main)
            .sink { [weak self] image in
                self?.imageView.image = image
                self?.preferredContentSize = image?.size ?? .zero
        }
        .store(in: &cancelBag)
    }

    // MARK: - Elements

    private lazy var titleField = with(UILabel()) {
        $0.translatesAutoresizingMaskIntoConstraints = false
        $0.numberOfLines = 2
        $0.adjustsFontSizeToFitWidth = true
        $0.textColor = .white

        $0.text = viewModel.title
    }

    private let titleContainerView = with(
    GradientView(colors: [UIColor.black.withAlphaComponent(0.0), UIColor.black.withAlphaComponent(0.6)])
    ) {
        $0.translatesAutoresizingMaskIntoConstraints = false
        $0.clipsToBounds = true
    }

    private let imageView: UIImageView = with(UIImageView()) {
        $0.translatesAutoresizingMaskIntoConstraints = false
        $0.clipsToBounds = true
        $0.contentMode = .scaleAspectFit
    }

    // MARK: - Layout

    private func layoutElements() {
        view.addSubview(imageView)
        imageView.pin(to: view, constraints: [
            equal(\.leadingAnchor),
            equal(\.trailingAnchor),
            equal(\.topAnchor),
            equal(\.bottomAnchor)
        ])

        view.addSubview(titleContainerView)
        titleContainerView.pin(to: view, constraints: [
            equal(\.leadingAnchor),
            equal(\.trailingAnchor),
            equal(\.bottomAnchor)
        ])

        titleContainerView.addSubview(titleField)
        titleField.pin(to: titleContainerView, constraints: [
            equal(\.leadingAnchor, constant: 10.0),
            equal(\.trailingAnchor, constant: -10.0),
            equal(\.topAnchor, constant: 30.0),
            equal(\.bottomAnchor, constant: -10.0)
        ])
    }

}
