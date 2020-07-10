//
//  UICollectionViewLayout+Gallery.swift
//  Farlake
//
//  Created by Boy van Amstel on 04/07/2020.
//  Copyright © 2020 Boy van Amstel. All rights reserved.
//

import UIKit

extension UICollectionViewLayout {
    static var galleryLayout: UICollectionViewLayout {
        // swiftlint:disable line_length
        return UICollectionViewCompositionalLayout { (_: Int, layoutEnvironment: NSCollectionLayoutEnvironment) -> NSCollectionLayoutSection? in
            // swiftlint:enable line_length

            let containerWidth = layoutEnvironment.container.contentSize.width
            let columnCount = min(5, (containerWidth / 200.0).rounded())
            let largeColumnCount: CGFloat = containerWidth > 1000.0 ? 2 : 1

            // Large item
            let largeItem = NSCollectionLayoutItem(
                layoutSize: NSCollectionLayoutSize(
                    widthDimension: .fractionalWidth(1.0 / largeColumnCount),
                    heightDimension: .fractionalWidth(0.5))
            )

            largeItem.contentInsets = NSDirectionalEdgeInsets(equal: 2.0)

            let largeGroup = NSCollectionLayoutGroup.horizontal(
                layoutSize: NSCollectionLayoutSize(
                    widthDimension: .fractionalWidth(1.0),
                    heightDimension: .fractionalWidth(0.5)),
                subitems: [largeItem])

            // Columns
            let columnItem = NSCollectionLayoutItem(
                layoutSize: NSCollectionLayoutSize(
                    widthDimension: .fractionalWidth(1.0 / columnCount),
                    heightDimension: .fractionalWidth(1.0 / columnCount))
            )

            columnItem.contentInsets = NSDirectionalEdgeInsets(equal: 2.0)

            let columnGroup = NSCollectionLayoutGroup.horizontal(
                layoutSize: NSCollectionLayoutSize(
                    widthDimension: .fractionalWidth(1.0),
                    heightDimension: .fractionalWidth(1.0 / columnCount)),
                subitems: [columnItem])

            // Section
            let nestedGroup = NSCollectionLayoutGroup.vertical(
                layoutSize: NSCollectionLayoutSize(
                    widthDimension: .fractionalWidth(1.0),
                    heightDimension: .fractionalWidth(0.5 + (1.0 / columnCount))),
                subitems: [largeGroup, columnGroup]
            )
            return NSCollectionLayoutSection(group: nestedGroup)
        }
    }
}
