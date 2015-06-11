//
//  UI_Tests_AppUITests.swift
//  UI Tests AppUITests
//
//  Created by Joseph Duffy on 11/06/2015.
//  Copyright © 2015 Yetii Ltd. All rights reserved.
//

import Foundation
import XCTest

class UI_Tests_AppUITests: XCTestCase {
        
    override func setUp() {
        super.setUp()
        
        // Put setup code here. This method is called before the invocation of each test method in the class.
        
        // In UI tests it is usually best to stop immediately when a failure occurs.
        continueAfterFailure = false
        // UI tests must launch the application that they test. Doing this in setup will make sure it happens for each test method.
        XCUIApplication().launch()
    }
    
    override func tearDown() {
        // Put teardown code here. This method is called after the invocation of each test method in the class.
        super.tearDown()
    }
    
    func testExample() {
        let app = XCUIApplication()
        app.buttons["Set PIN"].tap()

        app.keys["2"].tap()
        app.keys["5"].tap()
        app.keys["8"].tap()
        app.keys["0"].tap()

        app.keys["2"].tap()
        app.keys["5"].tap()
        app.keys["8"].tap()
        app.keys["0"].tap()
    }
    
}
