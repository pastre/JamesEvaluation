//
//  JamesEvaluationTests.swift
//  JamesEvaluationTests
//
//  Created by Bruno Pastre on 31/08/20.
//  Copyright © 2020 Bruno Pastre. All rights reserved.
//

import XCTest
@testable import JamesEvaluation

class JamesEvaluationTests: XCTestCase {

    var loader = CharacterLoader()
    override func setUpWithError() throws {
        // Put setup code here. This method is called before the invocation of each test method in the class.
    }

    override func tearDownWithError() throws {
        // Put teardown code here. This method is called after the invocation of each test method in the class.
    }

    func testLoadLastCharacters() throws {
        let expectation = XCTestExpectation(description: "Load last characters")
        
        let loader = CharacterLoader()
        
        loader.loadCharacters { (characters, error) in
        
            if let error = error {
                XCTFail("Failed to load!, \(error)")
                return
            }
        
        
            loader.currentResponse = .atPage(loader.currentResponse.pages)
        
            loader.loadCharacters { characters, error in
                if let error = error {
                    XCTFail("Failed to load!, \(error)")
                    return
                }
                
                loader.loadCharacters { (characters, error) in

                    if let error = error {
                        if error is CharacterLoaderError {
                            expectation.fulfill()
                            return
                        }
                        
                        XCTFail("Failed to load!, \(error)")
                        return
                    }
                }
            }
        }
    
        
        self.wait(for: [expectation], timeout: 20)
    }
    
    func testCharacterLoading() throws {
        let expectation = XCTestExpectation(description: "Load 4 character pages")
        
        let loader = CharacterLoader()
        loader.loadCharacters { (newCharacters, error) in
            if let error = error {
                XCTFail("Failed to load!, \(error)")
                return
            }
            
            loader.loadCharacters { (newCharacters, error) in
                if let error = error {
                    XCTFail("Failed to load!, \(error)")
                    return
                }
                
                loader.loadCharacters { (newCharacters, error) in
                    if let error = error {
                        XCTFail("Failed to load!, \(error)")
                        return
                    }

                    loader.loadCharacters { (newCharacters, error) in
                        if let error = error {
                            XCTFail("Failed to load!, \(error)")
                            return
                        }
                        
                        expectation.fulfill()
                        
                    }
                }
            }
        }
        
        self.wait(for: [expectation], timeout: 20)
    }

    func testPerformanceExample() throws {
        // This is an example of a performance test case.
        self.measure {
            // Put the code you want to measure the time of here.
        }
    }

}
