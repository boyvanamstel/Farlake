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

        _ = service.load(resource) { collection in
            XCTAssertEqual(collection!.artObjects.count, 10)

            let artObject = collection!.artObjects.first!

            XCTAssertEqual(artObject.title, "The Milkmaid")
            XCTAssertEqual(artObject.principalOrFirstMaker, "Johannes Vermeer")

            XCTAssertEqual(artObject.permitDownload, true)
            XCTAssertEqual(artObject.webImage?.width, 2261)
            XCTAssertEqual(artObject.webImage?.height, 2548)
            XCTAssertEqual(artObject.webImage?.url, "https://lh3.googleusercontent.com/cRtF3WdYfRQEraAcQz8dWDJOq3XsRX-h244rOw6zwkHtxy7NHjJOany7u4I2EG_uMAfNwBLHkFyLMENzpmfBTSYXIH_F=s0")

            expectation.fulfill()
        }
    }

}
