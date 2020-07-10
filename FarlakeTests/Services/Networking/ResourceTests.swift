//
//  ResourceTests.swift
//  FarlakeTests
//
//  Created by Boy van Amstel on 06/07/2020.
//  Copyright © 2020 Boy van Amstel. All rights reserved.
//

import XCTest
@testable import Farlake

class ResourceTests: XCTestCase {

    func testResourceParameterOrder() {
        let url = URL(string: "https://www.example.com")!
        let parameters: [String: CustomStringConvertible] = [
            "key": "abcDEF123",
            "q": "some query",
            "p": 0,
            "ps": 100
        ]

        for _ in 0...100 {
            let request = URLRequest(url: url, parameters: parameters)

            XCTAssertEqual(request?.url, URL(string: "https://www.example.com?key=abcDEF123&p=0&ps=100&q=some%20query"))
        }
    }

}
