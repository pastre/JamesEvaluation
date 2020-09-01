//
//  JamesEvaluationUITests.swift
//  JamesEvaluationUITests
//
//  Created by Bruno Pastre on 01/09/20.
//  Copyright © 2020 Bruno Pastre. All rights reserved.
//

import XCTest

class JamesEvaluationUITests: XCTestCase {

    let app = XCUIApplication()
    
    override func setUpWithError() throws {
        
        app.launch()
        continueAfterFailure = false
    }

    override func tearDownWithError() throws {
        
        
        // Put teardown code here. This method is called after the invocation of each test method in the class.
    }
    
    func testHomeScreen() {
        
    }
    
}
