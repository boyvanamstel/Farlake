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
        app.launchArguments.append("--uitesting")
    }

    // MARK: - Tests

    func testMainDisplayed() {
        app.launch()

        // Check if we're displaying the main view
        XCTAssertTrue(app.isDisplayingMain)

        // Check
        XCTAssert(app.staticTexts["Main"].exists)
    }

}
