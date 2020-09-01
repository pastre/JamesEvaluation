//
//  ViewController.swift
//  JamesEvaluation
//
//  Created by Bruno Pastre on 31/08/20.
//  Copyright © 2020 Bruno Pastre. All rights reserved.
//

import UIKit

class CharacterCollectionViewController: UIViewController, CharacterManagerDelegate {
    
    let charactersCollectionView: UICollectionView = {
        let layout = UICollectionViewFlowLayout()
        
        let collectionView = UICollectionView(frame: .zero, collectionViewLayout: layout)
        collectionView.backgroundColor = .clear
        collectionView.translatesAutoresizingMaskIntoConstraints = false
        
        return collectionView
    }()
    
    let loadingView: UIView = {
       
        let indicator = UIActivityIndicatorView(style: .large)
        let view = UIView()
        
        indicator.translatesAutoresizingMaskIntoConstraints = false
        
        view.addSubview(indicator)
        
        indicator.centerXAnchor.constraint(equalTo: view.centerXAnchor).isActive = true
        indicator.centerYAnchor.constraint(equalTo: view.centerYAnchor).isActive = true
        indicator.widthAnchor.constraint(equalTo: view.widthAnchor).isActive = true
        indicator.heightAnchor.constraint(equalTo: view.heightAnchor).isActive = true
        
        view.backgroundColor = .systemBackground
        view.layer.shadowColor = UIColor.black.cgColor
        view.layer.shadowOffset = CGSize(width: 1, height: 1)
        view.layer.shadowRadius = 3
        view.layer.shadowOpacity = 0.5
        view.layer.masksToBounds = false
        
        view.translatesAutoresizingMaskIntoConstraints = false
        indicator.startAnimating()
        
        return view
        
    }()
    
    var charactersManager: CharacterLoader!
    
    init(manager: CharacterLoader.Type) {
        super.init(nibName: nil, bundle: nil)
        
        let instance = manager.init(self.charactersCollectionView)
        
        self.charactersManager = instance
        self.charactersManager.delegate = self
        
    }
    
    required init?(coder: NSCoder) {
        super.init(coder: coder)
    }

    // MARK: - UIViewController lifecycle
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        self.view.backgroundColor = .systemBackground
        
        self.setupTableView()
        self.setupLoadingView()
        
        self.charactersManager.loadCharacters()
        
    }
    
    override func viewDidLayoutSubviews() {
        super.viewDidLayoutSubviews()
        self.loadingView.layer.cornerRadius = loadingView.frame.height / 2
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        
        self.navigationController?.navigationBar.prefersLargeTitles = true
        self.navigationItem.largeTitleDisplayMode = .always
        
        self.charactersCollectionView.reloadData()
    }
    
    // MARK: - Setup
    
    func setupTableView() {
        self.view.addSubview(self.charactersCollectionView)
        
        self.charactersCollectionView.topAnchor.constraint(equalTo: self.view.safeAreaLayoutGuide.topAnchor, constant: 0).isActive = true
        
        self.charactersCollectionView.leadingAnchor.constraint(equalTo: self.view.leadingAnchor).isActive = true
        self.charactersCollectionView.trailingAnchor.constraint(equalTo: self.view.trailingAnchor).isActive = true
            
        self.charactersCollectionView.bottomAnchor.constraint(equalTo: self.view.bottomAnchor).isActive = true
    
        self.charactersCollectionView.accessibilityIdentifier = "CharactersCollectionView"
    }
    
    func setupLoadingView() {
        
        self.view.addSubview(self.loadingView)
        
        self.loadingView.centerXAnchor.constraint(equalTo: self.view.centerXAnchor).isActive = true
        self.loadingView.bottomAnchor.constraint(equalTo: self.view.safeAreaLayoutGuide.bottomAnchor, constant: -40).isActive = true
        
        self.loadingView.heightAnchor.constraint(equalTo: self.view.heightAnchor, multiplier: 0.07).isActive = true
        self.loadingView.widthAnchor.constraint(equalTo: self.loadingView.heightAnchor).isActive = true
        
        self.onDoneLoading()
    }
    
    // MARK: - CharacterManagerDelegate
    
    func onCharacterPicked(_ character: Character) {
        let vc = CharacterViewController()
        
        vc.model = CharacterViewModel(character: character)
        
        self.navigationController?.pushViewController(vc, animated: true)
    }

    func onStartLoading() {
        UIView.animate(withDuration: 0.3) {
            self.loadingView.transform = .identity
        }
    }
    
    func onDoneLoading() {
        UIView.animate(withDuration: 0.3) {
            self.loadingView.transform = self.loadingView.transform.translatedBy(x: 0, y: self.view.frame.height)
        }
    }

}


