//
//  XCUIApplication+Helpers.swift
//  FarlakeUITests
//
//  Created by Boy van Amstel on 04/07/2020.
//  Copyright © 2020 Boy van Amstel. All rights reserved.
//

import XCTest

extension XCUIApplication {
    var isDisplayingGallery: Bool { collectionViews["Gallery"].exists }
    var isDisplayingGalleryDetail: Bool { otherElements["Gallery Detail"].exists }
}
