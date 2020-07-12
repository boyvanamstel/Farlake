//
//  FarlakeUITests.swift
//  FarlakeUITests
//
//  Created by Boy van Amstel on 12/07/2020.
//  Copyright © 2020 Boy van Amstel. All rights reserved.
//

import XCTest

class FarlakeUITests: XCTestCase {

    private var app: XCUIApplication!

    // MARK: - XCTestCase

    override func setUp() {
        super.setUp()

        continueAfterFailure = false

        app = XCUIApplication()
        app.launchArguments = ["-ui-testing"]

        app.launch()
    }

    // MARK: - Tests

    func testHappyFlow() {
        // Check if we're displaying the gallery view
        XCTAssertTrue(app.isDisplayingGallery)

        let collectionView = app.collectionViews["Gallery"]
        // Verify collection view contains 3 items
        XCTAssertEqual(collectionView.cells.count, 3)

        // Verify the first item has the correct title
        let cell = collectionView.cells.firstMatch
        XCTAssertTrue(cell.images["exclamationmark.triangle"].exists)
        XCTAssertTrue(cell.staticTexts["Title 1"].exists)

        // Proceed into detail view
        cell.tap()

        // Verify the detail view has appeared
        let galleryDetail = app.otherElements["Gallery Detail"]
        XCTAssertTrue(galleryDetail.waitForExistence(timeout: 5.0))

        // Collection view should be gone
        XCTAssertFalse(collectionView.exists)

        // Verify the detail view has the correct title
        XCTAssertTrue(galleryDetail.images["exclamationmark.triangle"].exists)
        XCTAssertTrue(galleryDetail.staticTexts["Title 1"].exists)

        // Go back to the gallery view
        #if targetEnvironment(macCatalyst)
        // Not entirely sure how to accuratly target the button
        // Regular methods do not seem to work
        app.toolbars.firstMatch.buttons.firstMatch.click()
        #else
        app.navigationBars.buttons.element(boundBy: 0).tap()
        #endif

        // Verify the gallery view has appeared
        XCTAssertTrue(collectionView.waitForExistence(timeout: 5.0))

        // Gallery detail should be gone
        XCTAssertFalse(galleryDetail.exists)

        // Test context menu if not on macOS
        #if !targetEnvironment(macCatalyst)
        cell.press(forDuration: 3.0)

        // Preview should have appeared
        let preview = app.otherElements["Preview"]
        XCTAssertTrue(preview.waitForExistence(timeout: 5.0))
        #endif
    }
}
