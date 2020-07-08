//
//  CacheTests.swift
//  FarlakeTests
//
//  Created by Boy van Amstel on 07/07/2020.
//  Copyright © 2020 Boy van Amstel. All rights reserved.
//

import XCTest
@testable import Farlake

class CacheTests: XCTestCase {

    func testCacheStorageAndRetrieval() {
        let cache = Cache<URL, String>()

        let key = URL(string: "https://www.example.com/test.jpg")!
        let value = "This string was cached"

        // Assert value isn't cached yet
        XCTAssertNil(cache[key])

        cache.insert(value, forKey: key)

        // Assert value exists now
        XCTAssertEqual(cache[key], value)

        cache.removeValue(forKey: key)

        // Assert value is removed
        XCTAssertNil(cache[key])
    }

}
