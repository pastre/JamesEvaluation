//
//  ViewController.swift
//  JamesEvaluation
//
//  Created by Bruno Pastre on 31/08/20.
//  Copyright © 2020 Bruno Pastre. All rights reserved.
//

import UIKit

class ViewController: UIViewController, CharacterManagerDelegate {
    
    let charactersCollectionView: UICollectionView = {
        let layout = UICollectionViewFlowLayout()
        
        let collectionView = UICollectionView(frame: .zero, collectionViewLayout: layout)
        collectionView.backgroundColor = .clear
        collectionView.translatesAutoresizingMaskIntoConstraints = false
        
        return collectionView
    }()
    
    
    var charactersManager: CharacterLoader!
    
    func configure(manager: CharacterLoader) {
        self.charactersManager = manager
        self.charactersManager.delegate = self
    }
    // MARK: - UIViewController lifecycle
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        self.view.backgroundColor = .white
        
        self.setupTableView()
        self.charactersManager.loadCharacters()
        
    }
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        
        self.navigationController?.navigationBar.prefersLargeTitles = true
        self.navigationItem.title = "Characters"
        self.navigationItem.largeTitleDisplayMode = .always
        
    }
    
    // MARK: - Setup
    
    func setupTableView() {
        self.view.addSubview(self.charactersCollectionView)
        
        self.charactersCollectionView.topAnchor.constraint(equalTo: self.view.topAnchor, constant: 20).isActive = true
        self.charactersCollectionView.leadingAnchor.constraint(equalTo: self.view.leadingAnchor).isActive = true
        self.charactersCollectionView.trailingAnchor.constraint(equalTo: self.view.trailingAnchor).isActive = true
        self.charactersCollectionView.bottomAnchor.constraint(equalTo: self.view.bottomAnchor).isActive = true
    }
    
    // MARK: - CharacterManagerDelegate
    
    func onCharacterPicked(_ character: Character) {
        let vc = CharacterViewController()
        
        vc.model = CharacterViewModel(character: character)
        
        self.navigationController?.pushViewController(vc, animated: true)
    }


}


