//
//  TwitterAPIAppTests.swift
//  TwitterAPIAppTests
//
//  Created by David Zack Walker on 04.06.20.
//  Copyright © 2020 dsfw. All rights reserved.
//

import XCTest
@testable import TwitterAPIApp

class APICallBuilderTests: XCTestCase {

    private let exampleUrl = "www.example.com"
    
    override func setUpWithError() throws {
        // Put setup code here. This method is called before the invocation of each test method in the class.
    }

    override func tearDownWithError() throws {
        // Put teardown code here. This method is called after the invocation of each test method in the class.
    }

    func testApiCallBuilder_buildsCorrectly_withOneQueryParam() throws {
        let call = APICallBuilder()
            .baseUrl(url: exampleUrl)
            .addQueryParameter(paramName: "fakeParam", paramValue: "fakeValue")
            .build()
        
        XCTAssert(call.endpoint.url!.absoluteString == "www.example.com?fakeParam=fakeValue")
    }
    
    func testApiCallBuilder_buildsCorrectly_withMultipleQueryParams() throws {
        let call = APICallBuilder()
        .baseUrl(url: exampleUrl)
        .addQueryParameter(paramName: "fakeParam", paramValue: "fakeValue")
        .addQueryParameter(paramName: "fakeParam2", paramValue: "fakeValue2")
        .build()
        
        XCTAssert(call.endpoint.url!.absoluteString == "www.example.com?fakeParam=fakeValue&fakeParam2=fakeValue2")
    }

    func testApiCallBuilder_responseReceived() throws {
        let responseExpectation = expectation(description: "httpResponse")
        var responseReceived = false
        let call = APICallBuilder()
        .baseUrl(url: exampleUrl)
        .addQueryParameter(paramName: "fakeParam", paramValue: "fakeValue")
        .onHttpResponse(httpResponseHandler: {
            res in
            responseReceived = true
            responseExpectation.fulfill()
        })
            .build()
        
        call.execute()
        
        waitForExpectations(timeout: 10, handler: nil)
        
        XCTAssert(responseReceived)
    }
    
    
}
