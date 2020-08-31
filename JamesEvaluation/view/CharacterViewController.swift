//
//  CharacterViewController.swift
//  JamesEvaluation
//
//  Created by Bruno Pastre on 31/08/20.
//  Copyright © 2020 Bruno Pastre. All rights reserved.
//

import UIKit


class CharacterViewController: UIViewController, CharacterViewModelDelegate {

    var model: CharacterViewModel!

    private let imageView: UIImageView = {
        let view = UIImageView()
        
        view.contentMode = .scaleAspectFill
        view.clipsToBounds = true
        
        view.translatesAutoresizingMaskIntoConstraints = false
        return view
    }()
    
    private let characterNameLabel: UILabel = {
        let view = UILabel()
//
//        view.numberOfLines = 2
//        view.minimumScaleFactor = 0.5
//        view.adjustsFontSizeToFitWidth = true
//
        view.font = .preferredFont(forTextStyle: .largeTitle)
        view.translatesAutoresizingMaskIntoConstraints = false
        
        return view
    }()
    
    private let characterStatusLabel: UILabel = {
        let view = UILabel()
        
        view.numberOfLines = 1
        view.minimumScaleFactor = 0.5
        view.adjustsFontSizeToFitWidth = true
        
        view.textColor = #colorLiteral(red: 0.6000000238, green: 0.6000000238, blue: 0.6000000238, alpha: 1)
        view.font = .systemFont(ofSize: 20, weight: .light)
        view.translatesAutoresizingMaskIntoConstraints = false
        
        return view
    }()
    
    private let locationHintLabel: UILabel = {
        let view = UILabel()
        
        view.numberOfLines = 1
        view.minimumScaleFactor = 0.2
        view.adjustsFontSizeToFitWidth = true
        
        view.text = "Last known location:"
        view.textColor = #colorLiteral(red: 0.6000000238, green: 0.6000000238, blue: 0.6000000238, alpha: 1)
        view.font = .systemFont(ofSize: 18, weight: .light)
        view.translatesAutoresizingMaskIntoConstraints = false
        
        return view
    }()
    
    private let locationLabel: UILabel = {
        let view = UILabel()
        
        view.numberOfLines = 1
        view.minimumScaleFactor = 0.5
        view.adjustsFontSizeToFitWidth = true
        
        view.font = .systemFont(ofSize: 20, weight: .medium)
        view.translatesAutoresizingMaskIntoConstraints = false
        
        return view
    }()
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        self.view.backgroundColor = .white
        
        self.model.delegate = self
        
        self.setupImageView()
        self.setupNameLabel()
        
        // Do any additional setup after loading the view.
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        self.updateInterface()
    }
    
    func setupImageView() {
        self.view.addSubview(self.imageView)
        
        self.imageView.topAnchor.constraint(equalTo: self.view.topAnchor).isActive = true
        self.imageView.leadingAnchor.constraint(equalTo: self.view.leadingAnchor).isActive = true
        self.imageView.trailingAnchor.constraint(equalTo: self.view.trailingAnchor).isActive = true
        
        self.imageView.heightAnchor.constraint(equalTo: self.view.heightAnchor, multiplier: 0.3).isActive = true
    }
    
    func setupNameLabel() {
        self.view.addSubview(self.characterNameLabel)
        
        self.characterNameLabel.topAnchor.constraint(equalTo: self.imageView.bottomAnchor, constant: 20).isActive = true
        
        self.characterNameLabel.leadingAnchor.constraint(equalTo: self.imageView.leadingAnchor, constant: 20).isActive = true
    }
    
    //MARK: - CharacterViewDelegate
    func updateInterface() {
        if let image = self.model.character.loadedImage {
            self.imageView.image = UIImage(data: image)
        }
        
        self.characterNameLabel.text = self.model.character.name
    }
    

    

    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destination.
        // Pass the selected object to the new view controller.
    }
    */

}
