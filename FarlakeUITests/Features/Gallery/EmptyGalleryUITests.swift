//
//  EmptyGalleryUITests.swift
//  FarlakeUITests
//
//  Created by Boy van Amstel on 10/07/2020.
//  Copyright © 2020 Boy van Amstel. All rights reserved.
//

import XCTest

class EmptyGalleryUITests: XCTestCase {

    private var app: XCUIApplication!

    // MARK: - XCTestCase

    override func setUp() {
        super.setUp()

        continueAfterFailure = false

        app = XCUIApplication()
        app.launchArguments = ["-ui-testing", "-test-entry-point", "gallery", "-test-gallery-empty"]

        app.launch()
    }

    // MARK: - Tests

    func testGalleryDisplayed() {
        // Check if we're displaying the gallery view
        XCTAssertTrue(app.isDisplayingGallery)
    }

    func testIsEmpty() {
        XCTAssertEqual(app.collectionViews.cells.count, 0)

        XCTAssertTrue(app.images["Gallery Empty Indicator"].exists)
        XCTAssertTrue(app.staticTexts["Gallery Empty Label"].exists)
    }

}
