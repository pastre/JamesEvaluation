//
//  CharacterCollectionViewManager.swift
//  JamesEvaluation
//
//  Created by Bruno Pastre on 31/08/20.
//  Copyright © 2020 Bruno Pastre. All rights reserved.
//

import UIKit

protocol CharacterManagerDelegate: class {
    func onCharacterPicked(_ character: Character)
}

class CharacterManager: NSObject, UICollectionViewDelegateFlowLayout, UICollectionViewDataSource {
    
    private let cellIdentifier = "CHARACTER_CELL"
    private var characterProvider: CharacterProvider!
    
    private var characters: [Character] = []
    private var collectionView: UICollectionView!
    
    var delegate: CharacterManagerDelegate?
    
    init(_ collectionView: UICollectionView) {
        self.collectionView = collectionView
        
        super.init()
        
        collectionView.delegate = self
        collectionView.dataSource = self
        
        collectionView.register(CharacterCollectionViewCell.self, forCellWithReuseIdentifier: cellIdentifier)
        
        self.characterProvider = CharacterLoader()
        
    }
    
    // MARK: - UI methods
    
    func loadCharacters() {
        self.characterProvider.loadCharacters { (newCharacters, error) in
            guard let characters = newCharacters else { return }

            self.characters.append(contentsOf: characters)
            self.collectionView.reloadData()
        }
    }
    
    //MARK: - collectionView Datasource & delegate
    func numberOfSections(in collectionView: UICollectionView) -> Int {
        1
    }
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        self.characters.count
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: cellIdentifier, for: indexPath) as! CharacterCollectionViewCell
        
        cell.character = self.characters[indexPath.item]
        cell.backgroundColor = .white
        
        cell.contentView.layer.cornerRadius = 20
        cell.contentView.layer.masksToBounds = true
        
        cell.layer.shadowColor = UIColor.black.cgColor
        cell.layer.shadowOffset = CGSize(width: 1, height: 1)
        cell.layer.shadowRadius = 3
        cell.layer.shadowOpacity = 0.5
        cell.layer.masksToBounds = false
        cell.layer.cornerRadius = 20
        
        return cell
    }
    
    func collectionView(_ collectionView: UICollectionView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        collectionView.frame.height * 0.2
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        return CGSize(width: collectionView.frame.width * 0.95, height: collectionView.frame.height * 0.2)
    }
    
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        self.delegate?.onCharacterPicked(self.characters[indexPath.item])
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, minimumLineSpacingForSectionAt section: Int) -> CGFloat {
        return 20
    }
}

