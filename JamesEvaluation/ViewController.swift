//
//  ViewController.swift
//  JamesEvaluation
//
//  Created by Bruno Pastre on 31/08/20.
//  Copyright © 2020 Bruno Pastre. All rights reserved.
//

import UIKit

class ViewController: UIViewController {

    var charactersTableView: UITableView = {
        let tableView = UITableView()
        
        tableView.translatesAutoresizingMaskIntoConstraints = false
        
        return tableView
    }()
    
    var charactersManager: CharacterManager!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        self.charactersManager = CharacterManager(self.charactersTableView)
        
        self.setupTableView()
    }
    
    func setupTableView() {
        self.view.addSubview(self.charactersTableView)
        
        self.charactersTableView.topAnchor.constraint(equalTo: self.view.topAnchor).isActive = true
        self.charactersTableView.leadingAnchor.constraint(equalTo: self.view.leadingAnchor).isActive = true
        self.charactersTableView.trailingAnchor.constraint(equalTo: self.view.trailingAnchor).isActive = true
        self.charactersTableView.bottomAnchor.constraint(equalTo: self.view.bottomAnchor).isActive = true
        
        self.charactersTableView.separatorStyle = .none
        
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        
        self.charactersManager.loadCharacters()
    }


}


