//
//  FavoriteCharacterCollectionViewModel.swift
//  JamesEvaluation
//
//  Created by Bruno Pastre on 31/08/20.
//  Copyright © 2020 Bruno Pastre. All rights reserved.
//

import UIKit

class FavoriteCharacterCollectionViewModel: CharacterCollectionViewModel, CharacterLoader {
    
    let storage = StorageFacade.instance
    override init(_ collectionView: UICollectionView) {
        super.init(collectionView)
        
        NotificationCenter.default.addObserver(forName: StorageFacade.favoritesDidChange, object: nil, queue: nil) { (notification) in
            self.loadCharacters()
        }
    }
    
    func loadCharacters() {
        
        self.characters = self.storage.getFavorites()
        
        self.collectionView.reloadData()
        
    }
}
