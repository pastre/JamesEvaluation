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
        app.cells["CharactersCollectionViewCell"].firstMatch.tap()
        
        
    }
}
