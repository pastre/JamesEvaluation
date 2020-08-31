//
//  ViewController.swift
//  JamesEvaluation
//
//  Created by Bruno Pastre on 31/08/20.
//  Copyright © 2020 Bruno Pastre. All rights reserved.
//

import UIKit

class ViewController: UIViewController, CharacterManagerDelegate {
    
    var charactersCollectionView: UICollectionView = {
        let layout = UICollectionViewFlowLayout()
        
        let collectionView = UICollectionView(frame: .zero, collectionViewLayout: layout)
        collectionView.backgroundColor = .clear
        collectionView.translatesAutoresizingMaskIntoConstraints = false
        
        return collectionView
    }()
    
    var charactersManager: CharacterManager!
    
    // MARK: - UIViewController lifecycle
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        self.charactersManager = CharacterManager(self.charactersCollectionView)
        self.charactersManager.delegate = self
        self.setupTableView()
    }
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        
        self.charactersManager.loadCharacters()
    }
    
    // MARK: - Setup
    
    func setupTableView() {
        self.view.addSubview(self.charactersCollectionView)
        
        self.charactersCollectionView.topAnchor.constraint(equalTo: self.view.topAnchor).isActive = true
        self.charactersCollectionView.leadingAnchor.constraint(equalTo: self.view.leadingAnchor).isActive = true
        self.charactersCollectionView.trailingAnchor.constraint(equalTo: self.view.trailingAnchor).isActive = true
        self.charactersCollectionView.bottomAnchor.constraint(equalTo: self.view.bottomAnchor).isActive = true
    }
    
    // MARK: - CharacterManagerDelegate
    
    func onCharacterPicked(_ character: Character) {
        // TODO: Change to navigation
        let vc = CharacterViewController()
        
        vc.character = character
        
        self.present(vc, animated: true, completion: nil)
    }


}


