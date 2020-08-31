//
//  ViewController.swift
//  JamesEvaluation
//
//  Created by Bruno Pastre on 31/08/20.
//  Copyright © 2020 Bruno Pastre. All rights reserved.
//

import UIKit

class ViewController: UIViewController {

    var charactersCollectionView: UICollectionView = {
        let collectionView = UICollectionView(frame: .zero, collectionViewLayout: UICollectionViewFlowLayout())
        
        collectionView.translatesAutoresizingMaskIntoConstraints = false
        
        return collectionView
    }()
    var charactersManager: CharacterCollectionViewManager!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        self.charactersManager = CharacterCollectionViewManager(self.charactersCollectionView)
    }
    
    


}

