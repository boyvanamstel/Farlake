//
//  GalleryDetailTests.swift
//  FarlakeUITests
//
//  Created by Boy van Amstel on 12/07/2020.
//  Copyright © 2020 Boy van Amstel. All rights reserved.
//

import XCTest

class GalleryUITests: XCTestCase {

    private var app: XCUIApplication!

    // MARK: - XCTestCase

    override func setUp() {
        super.setUp()

        continueAfterFailure = false

        app = XCUIApplication()
        app.launchArguments = ["-ui-testing", "-test-entry-point", "galleryDetail"]

        app.launch()
    }

    // MARK: - Tests

    func testGalleryDisplayed() {
        // Check if we're displaying the gallery view
        XCTAssertTrue(app.isDisplayingGalleryDetail)
    }

    func testHasTitle() {
        XCTAssertTrue(app.images["exclamationmark.triangle"].exists)
        XCTAssertTrue(app.staticTexts["Title 1"].exists)
    }
}
