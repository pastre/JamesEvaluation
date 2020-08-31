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
    }
    
    


}

