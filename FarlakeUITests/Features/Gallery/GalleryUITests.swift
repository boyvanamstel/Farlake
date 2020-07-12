//
//  GalleryUITests.swift
//  FarlakeUITests
//
//  Created by Boy van Amstel on 04/07/2020.
//  Copyright © 2020 Boy van Amstel. All rights reserved.
//

import XCTest

class GalleryDetailUITests: XCTestCase {

    private var app: XCUIApplication!

    // MARK: - XCTestCase

    override func setUp() {
        super.setUp()

        continueAfterFailure = false

        app = XCUIApplication()
        app.launchArguments = ["-ui-testing", "-test-entry-point", "gallery"]

        app.launch()
    }

    // MARK: - Tests

    func testGalleryDisplayed() {
        // Check if we're displaying the gallery view
        XCTAssertTrue(app.isDisplayingGallery)
    }

    func testHasGalleryItems() {
        XCTAssertEqual(app.collectionViews.cells.count, 3)

        let cell = app.collectionViews.cells.firstMatch
        XCTAssertTrue(app.images["exclamationmark.triangle"].exists)
        XCTAssertTrue(cell.staticTexts["Title 1"].exists)
    }
}
