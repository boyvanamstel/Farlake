//
//  NSDirectionalEdgeInsets+Helpers.swift
//  AlbumFiller
//
//  Created by Boy van Amstel on 22/05/2020.
//  Copyright © 2020 Boy van Amstel. All rights reserved.
//

import UIKit

extension NSDirectionalEdgeInsets {
    init(equal: CGFloat) {
        self.init(top: equal, leading: equal, bottom: equal, trailing: equal)
    }
}
