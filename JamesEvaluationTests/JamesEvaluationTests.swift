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

    
    func testCharacterLoading() {
        let mocked = MockCharacterCollectionViewModel(UICollectionView(frame: .zero, collectionViewLayout: .init()))
        XCTAssert(mocked.characters.isEmpty)
        
        mocked.loadCharacters()
        
        XCTAssert(mocked.characters.count == mocked.getMockedDict().count)
        mocked.characters.enumerated().forEach {
            i, character in
            XCTAssert(character.id == mocked.getMockedDict()[i]["id"] as? Int)
        }
    }
    
    func testFavorites() {
        let storage = StorageFacade.instance
        
        let mocked = MockCharacterCollectionViewModel(UICollectionView(frame: .zero, collectionViewLayout: .init()))
        
        mocked.loadCharacters()
        
        guard let character = mocked.characters.first,  let id = mocked.getMockedDict()[0]["id"] as? Int else {
            XCTAssert(false)
            return
        }
        
        storage.clearFavorites()
        
        XCTAssert(storage.getFavorites().isEmpty)
        
        storage.addFavorite(character: character)
        
        XCTAssert(storage.getFavorites().first == mocked.characters.first)
        XCTAssert(mocked.characters.count == mocked.getMockedDict().count)
        
        storage.removeFavorite(character: character)
        XCTAssert(storage.getFavorites().isEmpty)
        
        let many = 100
        
        for _ in 0..<many {

            storage.addFavorite(character: character)
            
        }
        
        XCTAssert(storage.getFavorites().count == many)
        
        storage.getFavorites().forEach { (character) in
            XCTAssert(character.id == id)
        }
        
        for _ in 0...many {
            storage.removeFavorite(character: character)
        }
        
        XCTAssert(storage.getFavorites().count == 0)
        
    }
    
    func testLoadLastAPICharacters() throws {
        let expectation = XCTestExpectation(description: "Load last characters")
        
        let loader = APICharacterFetcher()
        
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
    
    func testAPICharacterLoading() throws {
        let expectation = XCTestExpectation(description: "Load 4 character pages")
        
        let loader = APICharacterFetcher()
        
        var current = loader.currentResponse.next
        
        loader.loadCharacters { (newCharacters, error) in
            if let error = error {
                XCTFail("Failed to load!, \(error)")
                return
            }
            
            XCTAssert(current != loader.currentResponse.next)
            current = loader.currentResponse.next
            
            loader.loadCharacters { (newCharacters, error) in
                if let error = error {
                    XCTFail("Failed to load!, \(error)")
                    return
                }

                XCTAssert(current != loader.currentResponse.next)
                current = loader.currentResponse.next
                
                loader.loadCharacters { (newCharacters, error) in
                    if let error = error {
                        XCTFail("Failed to load!, \(error)")
                        return
                    }

                    XCTAssert(current != loader.currentResponse.next)
                    current = loader.currentResponse.next
                    
                    loader.loadCharacters { (newCharacters, error) in
                        if let error = error {
                            XCTFail("Failed to load!, \(error)")
                            return
                        }
                        
                        XCTAssert(current != loader.currentResponse.next)
                        current = loader.currentResponse.next
                        
                        expectation.fulfill()
                        
                    }
                }
            }
        }
        
        self.wait(for: [expectation], timeout: 20)
    }
}
