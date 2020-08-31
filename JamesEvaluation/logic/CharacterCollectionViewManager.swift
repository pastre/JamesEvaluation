//
//  CharacterCollectionViewManager.swift
//  JamesEvaluation
//
//  Created by Bruno Pastre on 31/08/20.
//  Copyright © 2020 Bruno Pastre. All rights reserved.
//

import UIKit

protocol CharacterProvider {
    func loadCharacters(completion: @escaping ([Character]?, Error?) -> ())
}

protocol CharacterLoaderDelegate {
    func onCharactersLoaded(_ newCharacters: [Character])
    func onError(error: Error)
}

enum CharacterLoaderError: Error {
    case noMoreCharacters
}

class CharacterLoader: CharacterProvider {
    
    var apiFacade = APIFacade()
    var currentResponse: CharacterResponseMetadata!
    var delegate: CharacterLoaderDelegate!
    
    init(delegate: CharacterLoaderDelegate) {
        self.delegate = delegate
        self.currentResponse = CharacterResponseMetadata.first
    }
    
    func loadCharacters(completion: @escaping ([Character]?, Error?) -> ()) {
    
        guard let url = self.currentResponse.nextURL() else {
            self.delegate.onError(error: CharacterLoaderError.noMoreCharacters)
            
            return
        }
        
        
        self.apiFacade.getCharacters(url: url) { (characters, error) in
            guard let characters = characters else {
                self.delegate.onError(error: error!)
                
                return
            }
            
            self.delegate.onCharactersLoaded(characters)
        }
    }
}

class CharacterCollectionViewManager: NSObject, UICollectionViewDataSource, UICollectionViewDelegateFlowLayout, CharacterLoaderDelegate {
    
    var characterProvider: CharacterProvider!
    var characters: [Character] = []
    
    init(_ collectionView: UICollectionView) {
        super.init()
        
        collectionView.delegate = self
        collectionView.dataSource = self
        
        self.characterProvider = CharacterLoader(delegate: self)
        
    }
    
    func numberOfSections(in collectionView: UICollectionView) -> Int {
        1
    }
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        self.characters.count
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        return UICollectionViewCell()
    }
    
    func onCharactersLoaded(_ newCharacters: [Character]) {
        self.characters.append(contentsOf: newCharacters)
    }
    
    func onError(error: Error) {
        print("Error!", error)
    }

}

