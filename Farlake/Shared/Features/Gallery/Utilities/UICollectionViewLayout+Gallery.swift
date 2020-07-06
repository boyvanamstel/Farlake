//
//  UICollectionViewLayout+Gallery.swift
//  Farlake
//
//  Created by Boy van Amstel on 04/07/2020.
//  Copyright © 2020 Boy van Amstel. All rights reserved.
//

import UIKit

extension UICollectionViewLayout {
    static var galleryGridLayout: UICollectionViewCompositionalLayout {
        let columnCount: CGFloat = 3

        // Item
        let itemSize = NSCollectionLayoutSize(widthDimension: .fractionalWidth(1.0 / columnCount), heightDimension: .fractionalHeight(1.0))
        let item = NSCollectionLayoutItem(layoutSize: itemSize)
        item.contentInsets = NSDirectionalEdgeInsets(equal: 1.0)

        // Group
        let groupSize = NSCollectionLayoutSize(widthDimension: .fractionalWidth(1.0), heightDimension: .fractionalWidth(1.0 / columnCount))
        let group = NSCollectionLayoutGroup.horizontal(layoutSize: groupSize, subitems: [item])

        // Section
        let section = NSCollectionLayoutSection(group: group)

        return UICollectionViewCompositionalLayout(section: section)
    }
}
