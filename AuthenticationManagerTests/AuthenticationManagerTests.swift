//
//  AuthenticationManagerTests.swift
//  AuthenticationManager
//
//  Created by Joseph Duffy on 04/08/2014.
//  Copyright (c) 2014 Yetii Ltd. All rights reserved.
//

import UIKit
import XCTest
import AuthenticationManager

class AuthenticationManagerTests: XCTestCase {

    override func setUp() {
        super.setUp()
        // Put setup code here. This method is called before the invocation of each test method in the class.
    }
    
    override func tearDown() {
        // Put teardown code here. This method is called after the invocation of each test method in the class.
        super.tearDown()
    }

    func testClassIsSingleton() {
        let firstInstance = AuthenticationManager.sharedInstance
        let secondInstance = AuthenticationManager.sharedInstance
        XCTAssertTrue(firstInstance === secondInstance, "The same instance of AuthenticationManager should always be returned from the sharedInstance property")
    }
}
