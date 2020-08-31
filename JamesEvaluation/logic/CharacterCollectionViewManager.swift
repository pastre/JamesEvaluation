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


enum CharacterLoaderError: Error {
    case noMoreCharacters
}

class CharacterLoader: CharacterProvider {
    
    
    var apiFacade = APIFacade()
    var currentResponse: CharacterResponseMetadata!
    var canRequest: Bool = true
    
    init() {
        self.currentResponse = CharacterResponseMetadata.getFirst()
    }
    
    func loadCharacters(completion: @escaping ([Character]?, Error?) -> ()) {
        
        guard canRequest else { return }
        
        guard let url = self.currentResponse.nextURL() else {
            completion(nil, CharacterLoaderError.noMoreCharacters)
            return
        }
        
        self.apiFacade.getCharacters(url: url) { (response, error) in
            guard let response = response else {
                completion(nil, error)
                return
            }
            
            self.currentResponse = response.info
            completion(response.results, error)
        }
    }
    
}

class CharacterCollectionViewManager: NSObject, UICollectionViewDataSource, UICollectionViewDelegateFlowLayout {
    
    var characterProvider: CharacterProvider!
    var characters: [Character] = []
    
    init(_ collectionView: UICollectionView) {
        super.init()
        
        collectionView.delegate = self
        collectionView.dataSource = self
        
        self.characterProvider = CharacterLoader()
        
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

