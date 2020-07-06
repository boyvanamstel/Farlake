//
//  CollectionTests.swift
//  FarlakeTests
//
//  Created by Boy van Amstel on 06/07/2020.
//  Copyright © 2020 Boy van Amstel. All rights reserved.
//

import XCTest
@testable import Farlake

class CollectionTests: XCTestCase {

    private class MockNetworkService: NetworkService {
        func load<Object>(_ resource: Resource<Object>, completion: @escaping (Object?) -> ()) -> URLSessionDataTask? {

            let url =  Bundle(for: type(of: self)).url(forResource: "collection-vermeer", withExtension: "json")!
            let jsonData = try! Data(contentsOf: url)

            completion(resource.parse(jsonData))

            return nil
        }
    }

    func testParsingCollection() throws {

        let expectation = XCTestExpectation(description: "Parse collection")

        let resource = try! MockNetworkService.collection(query: "")
        let service = MockNetworkService()

        service.load(resource) { collection in
            XCTAssertNotNil(collection)
            XCTAssertEqual(collection?.artObjects.count, 10)

            for artObject in collection!.artObjects {
                XCTAssertNotNil(artObject.webImage)
            }

            expectation.fulfill()
        }
    }

}
