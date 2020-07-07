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

    // MARK: - Object lifecycle

    override init(frame: CGRect) {
        super.init(frame: frame)

        layoutElements()
    }

    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }

    // MARK: - Bindings

    private var cancelBag: [AnyCancellable] = []

    private func configureBindings() {
        cancelBag.removeAll()

        viewModel?.$image
            .subscribe(on: DispatchQueue.global(qos: .userInitiated))
            .map { $0?.resize(to: .scaleToFill, in: CGRect(CGSize(equal: 200.0))) }
            .receive(on: DispatchQueue.main)
            .assign(to: \.image, on: imageView)
            .store(in: &cancelBag)
    }

    // MARK: - Elements

    private let titleField = with(UILabel()) {
        $0.translatesAutoresizingMaskIntoConstraints = false
        $0.textAlignment = .center
    }
    private let imageView = with(UIImageView()) {
        $0.translatesAutoresizingMaskIntoConstraints = false
        $0.contentMode = .scaleAspectFill
        $0.clipsToBounds = true
    }

    // MARK: - Layout

    private func layoutElements() {
        contentView.addSubview(imageView)
        imageView.pin(to: self, constraints: [
            equal(\.leadingAnchor),
            equal(\.trailingAnchor),
            equal(\.topAnchor),
            equal(\.bottomAnchor)
        ])

        contentView.addSubview(titleField)
        titleField.pin(to: self, constraints: [
            equal(\.leadingAnchor),
            equal(\.trailingAnchor),
            equal(\.bottomAnchor)
        ])
    }

}
