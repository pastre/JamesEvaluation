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

    let loader = CharacterLoader()
    override func setUpWithError() throws {
        // Put setup code here. This method is called before the invocation of each test method in the class.
    }

    override func tearDownWithError() throws {
        // Put teardown code here. This method is called after the invocation of each test method in the class.
    }

    func testCharacterLoading() throws {
        let expectation = XCTestExpectation(description: "Load 4 character pages")

        print("AEEE")
        self.loader.loadCharacters { (response, error) in
            if let error = error {
                XCTFail("Failed to load!, \(error)")
                return
            }
            print("AEEE")
            
            self.loader.loadCharacters { (response, error) in
                if let error = error {
                    XCTFail("Failed to load!, \(error)")
                    return
                }
                print("AEEE")
                
                self.loader.loadCharacters { (response, error) in
                    if let error = error {
                        XCTFail("Failed to load!, \(error)")
                        return
                    }
                    print("AEEE")

                    self.loader.loadCharacters { (response, error) in
                        if let error = error {
                            XCTFail("Failed to load!, \(error)")
                            return
                        }
                        print("AEEE")
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
