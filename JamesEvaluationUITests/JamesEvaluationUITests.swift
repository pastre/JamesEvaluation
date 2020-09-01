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
        
        XCTAssert(app.staticTexts["Characters"].exists)
        XCTAssert(app.staticTexts["Characters"].isHittable)
        
        XCTAssert(app.collectionViews["CharactersCollectionView"].exists)
        XCTAssert(app.collectionViews["CharactersCollectionView"].isHittable)
        
        
        let sampleCell = app.cells["CharactersCollectionViewCell"].firstMatch
        
        XCTAssert(sampleCell.exists)
        XCTAssert(sampleCell.isHittable)
        
        XCTAssert(sampleCell.images.count == 1)
        XCTAssert(sampleCell.staticTexts.count == 2)
        
        sampleCell.tap()
                
    }
    
    func testCharacterScreen() {
        
        let strings = [
            "Alive - Male - Developer",
            "📍 Originally from Plains of Java",
            "📍 Currently at Swifty Seas",
            "Appears in 4 episodes"
        ]

        app.cells["CharactersCollectionViewCell"].firstMatch.tap()
        
        XCTAssert(app.staticTexts["Bruno 0"].exists)
        XCTAssert(app.staticTexts.matching(identifier: "Bruno 0").count == 3, "Number of matching texts: \(app.staticTexts.matching(identifier: "Bruno 0").count)")
        
                  
        strings.forEach {
            
            XCTAssert(app.staticTexts[$0].exists, "\($0) does not exist!")
            XCTAssert(app.staticTexts[$0].isHittable, "\($0) is not hittable!")
        }
        
        let favButton = app.navigationBars.buttons["favoriteMenuItem"]
        
        XCTAssert(favButton.exists)
        XCTAssert(favButton.isHittable)
        
        favButton.tap()
        favButton.tap()
    }
}
