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
        
        view.font = .preferredFont(forTextStyle: .largeTitle)
        view.numberOfLines = 2
        view.translatesAutoresizingMaskIntoConstraints = false
        
        return view
    }()
    
    private let characterStatusLabel: UILabel = {
        let view = UILabel()
        
        view.numberOfLines = 2
        view.textColor = #colorLiteral(red: 0.6000000238, green: 0.6000000238, blue: 0.6000000238, alpha: 1)
        view.font = .preferredFont(forTextStyle: .body)
        view.translatesAutoresizingMaskIntoConstraints = false
        
        return view
    }()
    
    
    private let originLabel: UILabel = {
        let view = UILabel()
        
        view.numberOfLines = 2
        view.font = .preferredFont(forTextStyle: .callout)
        view.translatesAutoresizingMaskIntoConstraints = false
        
        return view
    }()
    private let locationLabel: UILabel = {
        let view = UILabel()
        
        view.numberOfLines = 2
        view.font = .preferredFont(forTextStyle: .callout)
        view.translatesAutoresizingMaskIntoConstraints = false
        
        return view
    }()
    
    private let createdAtLabel: UILabel = {
        let view = UILabel()
        
        view.numberOfLines = 2
        view.font = .preferredFont(forTextStyle: .callout)
        view.translatesAutoresizingMaskIntoConstraints = false
        
        return view
    }()
    
    private let episodesLabel: UILabel = {
        let view = UILabel()
        
        view.numberOfLines = 2
        view.font = .preferredFont(forTextStyle: .callout)
        view.translatesAutoresizingMaskIntoConstraints = false
        
        return view
    }()
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        self.view.backgroundColor = .white
        
        self.model.delegate = self
        
        self.setupFavoriteButton()
        self.setupImageView()
        self.setupNameLabel()
        self.setupStatusLabel()
        self.setupLocationLabels()
        self.setupCreatedAtLabel()
        self.setupEpisodesLabel()
        
        // Do any additional setup after loading the view.
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        
        self.navigationController?.navigationBar.prefersLargeTitles = false
        self.navigationItem.title =  self.model.character.name
        self.navigationItem.largeTitleDisplayMode = .never
        
        self.updateInterface()
    }
    
    @objc func onFavoriteChanged(){
        self.model.onFavorite()
        self.setupFavoriteButton()
    }
    
    //MARK: - Callbacks
    
    func setupFavoriteButton() {
        
        self.navigationItem.rightBarButtonItem = .init(image: UIImage(systemName: self.model.isFavorite() ? "star.fill" : "star"), style: .done, target: self, action: #selector(self.onFavoriteChanged))
    }
    
    func setupImageView() {
        self.view.addSubview(self.imageView)
        
        self.imageView.topAnchor.constraint(equalTo: self.view.topAnchor).isActive = true
        self.imageView.leadingAnchor.constraint(equalTo: self.view.leadingAnchor).isActive = true
        self.imageView.trailingAnchor.constraint(equalTo: self.view.trailingAnchor).isActive = true
        
        self.imageView.heightAnchor.constraint(equalTo: self.view.widthAnchor).isActive = true
    }
    
    func setupNameLabel() {
        self.view.addSubview(self.characterNameLabel)
        
        self.characterNameLabel.topAnchor.constraint(equalTo: self.imageView.bottomAnchor, constant: 20).isActive = true
        
        self.characterNameLabel.leadingAnchor.constraint(equalTo: self.imageView.leadingAnchor, constant: 20).isActive = true
        
        self.characterNameLabel.trailingAnchor.constraint(equalTo: self.view.trailingAnchor, constant: -20).isActive = true
    }
    
    func setupStatusLabel() {
        self.view.addSubview(self.characterStatusLabel)
        
        self.characterStatusLabel.topAnchor.constraint(equalTo: self.characterNameLabel.bottomAnchor).isActive = true
        
        self.characterStatusLabel.leadingAnchor.constraint(equalTo: self.characterNameLabel.leadingAnchor).isActive = true
    }
    
    func setupLocationLabels() {
        self.view.addSubview(self.originLabel)
        self.view.addSubview(self.locationLabel)
        
        
        self.originLabel.topAnchor.constraint(equalTo: self.characterStatusLabel.bottomAnchor, constant: 10).isActive = true
        
        self.locationLabel.topAnchor.constraint(equalTo: self.originLabel.bottomAnchor).isActive = true
        
        self.originLabel.leadingAnchor.constraint(equalTo: self.characterNameLabel.leadingAnchor).isActive = true
        self.locationLabel.leadingAnchor.constraint(equalTo: self.characterNameLabel.leadingAnchor).isActive = true
        
        self.originLabel.trailingAnchor.constraint(equalTo: self.view.trailingAnchor, constant: -20).isActive = true
        self.locationLabel.trailingAnchor.constraint(equalTo: self.view.trailingAnchor, constant: -20).isActive = true
        
    }
    
    func setupCreatedAtLabel() {
        self.view.addSubview(self.createdAtLabel)
        
        
        self.createdAtLabel.topAnchor.constraint(equalTo: self.locationLabel.bottomAnchor).isActive = true
        
        self.createdAtLabel.leadingAnchor.constraint(equalTo: self.characterNameLabel.leadingAnchor).isActive = true
        
        self.createdAtLabel.trailingAnchor.constraint(equalTo: self.view.trailingAnchor, constant: -20).isActive = true
        
        
    }
    
    func setupEpisodesLabel() {
        
        self.view.addSubview(self.episodesLabel)
        
        self.episodesLabel.bottomAnchor.constraint(equalTo: self.view.safeAreaLayoutGuide.bottomAnchor).isActive = true
        
        self.episodesLabel.leadingAnchor.constraint(equalTo: self.characterNameLabel.leadingAnchor).isActive = true
        
        self.episodesLabel.trailingAnchor.constraint(equalTo: self.view.trailingAnchor, constant: -20).isActive = true
        
        self.episodesLabel.heightAnchor.constraint(equalTo: self.view.heightAnchor, multiplier: 0.05).isActive = true
        
        
        self.locationLabel.heightAnchor.constraint(equalTo: self.episodesLabel.heightAnchor).isActive = true
        self.originLabel.heightAnchor.constraint(equalTo: self.episodesLabel.heightAnchor).isActive = true
        self.createdAtLabel.heightAnchor.constraint(equalTo: self.episodesLabel.heightAnchor).isActive = true
    }
    
    //MARK: - CharacterViewDelegate
    func updateInterface() {
        if let image = self.model.character.loadedImage {
            self.imageView.image = UIImage(data: image)
        }
        
        self.characterNameLabel.text = self.model.character.name
        self.characterStatusLabel.text = self.model.getStatus() + " - " + self.model.getGender() + " - " + self.model.getSpecies()
       
        self.episodesLabel.text = "Appears in \(self.model.character.episode.count) episode"  + (self.model.character.episode.count > 1 ? "s" : "")
        
        self.setAttributedText( "📍 Originally from ", bold: self.model.character.origin.name, on: self.originLabel)
        
        self.setAttributedText("📍 Currently at ", bold: self.model.character.location.name, on: self.locationLabel)
        
        let formatter = DateFormatter()
        formatter.dateFormat = "dd/MM/YYYY HH:mm"
        
        self.setAttributedText("🕰 Created at ", bold: formatter.string(from: self.model.character.createdAt()), on: self.createdAtLabel)
    }
    
    private func setAttributedText(_ normal: String, bold: String, on label: UILabel) {
        
        let str =  NSMutableAttributedString(string: normal )
        let boldText = NSAttributedString(string: bold, attributes: [NSAttributedString.Key.font : UIFont.boldSystemFont(ofSize: 17)])
        
        
        str.append(boldText)
        label.attributedText = str
        
    }
}
