//
//  APICharacterViewModel.swift
//  JamesEvaluation
//
//  Created by Bruno Pastre on 01/09/20.
//  Copyright © 2020 Bruno Pastre. All rights reserved.
//

import UIKit

class APICharacterCollectionViewModel: CharacterCollectionViewModel, CharacterLoader {
    
    var characterProvider: CharacterFetcher! = CharacterFetcher()
    var isLoading: Bool = false
    
    func loadCharacters() {
        self.delegate?.onStartLoading()
        self.characterProvider.loadCharacters { (newCharacters, error) in
            guard let characters = newCharacters else { return }

            self.characters.append(contentsOf: characters)
            self.delegate?.onDoneLoading()
            self.collectionView.reloadData()
        }
    }
    
    func collectionView(_ collectionView: UICollectionView, willDisplay cell: UICollectionViewCell, forItemAt indexPath: IndexPath) {
        
        if indexPath.item == self.characters.count - 1 {
            self.loadCharacters()
        }
    }
    
}

