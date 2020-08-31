//
//  CharacterCollectionViewManager.swift
//  JamesEvaluation
//
//  Created by Bruno Pastre on 31/08/20.
//  Copyright © 2020 Bruno Pastre. All rights reserved.
//

import UIKit


class CharacterManager: NSObject, UITableViewDataSource, UITableViewDelegate {
    
    var characterProvider: CharacterProvider!
    
    var characters: [Character] = []
    var tableView: UITableView!
    
    init(_ tableView: UITableView) {
        self.tableView = tableView
        
        super.init()
        
        tableView.delegate = self
        tableView.dataSource = self
        
        self.characterProvider = CharacterLoader()
        
    }
    
    // MARK: - UI methods
    
    func loadCharacters() {
        self.characterProvider.loadCharacters { (newCharacters, error) in
            guard let characters = newCharacters else { return }
            

            self.characters.append(contentsOf: characters)
            self.tableView.reloadData()
        }
    }
    
    //MARK: - tableView Datasource & delegate
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        self.characters.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        UITableViewCell()
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        tableView.frame.height * 0.2
    }

}

