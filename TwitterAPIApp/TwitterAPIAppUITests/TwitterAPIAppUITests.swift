//
//  TwitterAPIAppUITests.swift
//  TwitterAPIAppUITests
//
//  Created by David Zack Walker on 04.06.20.
//  Copyright © 2020 dsfw. All rights reserved.
//

import XCTest

class TwitterAPIAppUITests: XCTestCase {
    let app = XCUIApplication()
    
    override func setUp() {
        continueAfterFailure = false
        app.launch()
    }

    override func setUpWithError() throws {
        // Put setup code here. This method is called before the invocation of each test method in the class.

        // In UI tests it is usually best to stop immediately when a failure occurs.
        continueAfterFailure = false

        // In UI tests it’s important to set the initial state - such as interface orientation - required for your tests before they run. The setUp method is a good place to do this.
    }

    override func tearDownWithError() throws {
        // Put teardown code here. This method is called after the invocation of each test method in the class.
    }
    func testTabbarFavorites(){
        XCUIApplication().tabBars.buttons["Favorites"].tap()
        XCTAssertTrue(app.tabBars.buttons["Favorites"].exists)
                
    }
    func testTabbarTweets(){
        
        let tabBarsQuery = XCUIApplication().tabBars
        tabBarsQuery.buttons["Favorites"].tap()
        tabBarsQuery.buttons["Tweets"].tap()
        XCTAssertTrue(app.tabBars.buttons["Tweets"].exists)
    }
    func testFavoriteTweet(){
        sleep(5)
        app.tables.cells.element(boundBy: 0).swipeLeft()
        XCTAssertNoThrow(app.tables.cells.element(boundBy: 0).buttons["trailing0"].tap())
                
    }
    func testDeleteFavoriteExists(){
        sleep(5)
        app.tables.cells.element(boundBy: 0).swipeLeft()
        app.tables.cells.element(boundBy: 0).buttons["trailing0"].tap()
                
        XCUIApplication().tabBars.buttons["Favorites"].tap()
        app.tables.cells.element(boundBy: 0).swipeLeft()
        app.tables.cells.element(boundBy: 0).buttons["trailing0"].tap()
        
    }
    func testRefreshOnSwipeDown() {
        sleep(5)
        app.tables.cells.element(boundBy: 0).swipeDown()
        sleep(1)
        app.tables.cells.element(boundBy: 0).swipeLeft()
        app.tables.cells.element(boundBy: 0).buttons["trailing0"].tap()
    }
     
    

    func testLaunchPerformance() throws {
        if #available(macOS 10.15, iOS 13.0, tvOS 13.0, *) {
            // This measures how long it takes to launch your application.
            measure(metrics: [XCTOSSignpostMetric.applicationLaunch]) {
                XCUIApplication().launch()
            }
        }
    }
}
