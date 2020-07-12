//
//  GalleryCollectionViewCell.swift
//  Farlake
//
//  Created by Boy van Amstel on 04/07/2020.
//  Copyright © 2020 Boy van Amstel. All rights reserved.
//

import UIKit
import Combine

final class GalleryCollectionViewCell: UICollectionViewCell {
    static let reuseIdentifier = UUID().uuidString

    var viewModel: GalleryCollectionViewCellViewModel? {
        didSet {
            titleField.text = viewModel?.title ?? ""
            imageView.image = viewModel?.image

            configureBindings()
        }
    }

    private var image: UIImage? {
        didSet {
            // Dramatic effect
            UIView.transition(with: imageView,
                              duration: image == nil ? 0.0 : 0.25,
                              options: .transitionCrossDissolve,
                              animations: { self.imageView.image = self.image },
                              completion: nil)
        }
    }

    // MARK: - Object lifecycle

    override init(frame: CGRect) {
        super.init(frame: frame)

        layoutElements()
        configureFonts()
        configureColors()
    }

    required init?(coder: NSCoder) { fatalError("init(coder:) has not been implemented") }

    override func prepareForReuse() {
        super.prepareForReuse()

        viewModel = nil
    }

    // MARK: - Bindings

    private var cancelBag: [AnyCancellable] = []

    private func configureBindings() {
        cancelBag.removeAll()

        viewModel?.$image
            .subscribe(on: DispatchQueue.global(qos: .userInitiated))
            .receive(on: DispatchQueue.main)
            .assign(to: \.image, on: self)
            .store(in: &cancelBag)
    }

    // MARK: - Elements

    private let titleField = with(UILabel()) {
        $0.translatesAutoresizingMaskIntoConstraints = false
        $0.lineBreakMode = .byTruncatingTail
        $0.numberOfLines = 2
        $0.textColor = .white
    }

    private let titleContainerView = with(
    GradientView(colors: [UIColor.black.withAlphaComponent(0.0), UIColor.black.withAlphaComponent(0.6)])
    ) {
        $0.translatesAutoresizingMaskIntoConstraints = false
        $0.clipsToBounds = true
    }

    private let imageView = with(UIImageView()) {
        $0.translatesAutoresizingMaskIntoConstraints = false
        $0.contentMode = .scaleAspectFill
        $0.clipsToBounds = true
    }

    // MARK: - Layout

    private func layoutElements() {
        contentView.clipsToBounds = true

        contentView.addSubview(imageView)
        imageView.pin(to: contentView, constraints: [
            equal(\.leadingAnchor),
            equal(\.trailingAnchor),
            equal(\.topAnchor),
            equal(\.bottomAnchor)
        ])

        contentView.addSubview(titleContainerView)
        titleContainerView.pin(to: contentView, constraints: [
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

    // MARK: - Accessibility

    override func traitCollectionDidChange(_ previousTraitCollection: UITraitCollection?) {
        super.traitCollectionDidChange(previousTraitCollection)

        configureFonts()
        configureColors()
    }

    private func configureFonts() {
        titleField.font = .preferredFont(forTextStyle: .title3)
    }

    private func configureColors() {
        contentView.backgroundColor = traitCollection.userInterfaceStyle == .dark ? .darkGray : .lightGray
    }
}
