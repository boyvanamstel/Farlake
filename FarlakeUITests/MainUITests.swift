//
//  FarlakeUITests.swift
//  FarlakeUITests
//
//  Created by Boy van Amstel on 04/07/2020.
//  Copyright © 2020 Boy van Amstel. All rights reserved.
//

import XCTest

class MainUITests: XCTestCase {

    private var app: XCUIApplication!

    // MARK: - XCTestCase

    override func setUp() {
        super.setUp()

        continueAfterFailure = false

        app = XCUIApplication()
        app.launchArguments = ["-ui-testing", "-entry-point", "main"]

        app.launch()
    }

    // MARK: - Tests

    func testMainDisplayed() {
        // Check if we're displaying the main view
        XCTAssertTrue(app.isDisplayingMain)

        // Check if the main label exists
        XCTAssertTrue(app.staticTexts["Main"].exists)
    }

}
