//
//  CharacterTableViewCell.swift
//  JamesEvaluation
//
//  Created by Bruno Pastre on 31/08/20.
//  Copyright © 2020 Bruno Pastre. All rights reserved.
//

import UIKit

class CharacterCollectionViewCell: UICollectionViewCell {

    let apiFacade = APIFacade()
    
    private let characterImageView: UIImageView = {
        let view = UIImageView()
        
        view.translatesAutoresizingMaskIntoConstraints = false
        view.contentMode = .scaleAspectFit
        
        return view
    }()
    
    private let characterNameLabel: UILabel = {
        let view = UILabel()
        
        view.font = .systemFont(ofSize: 24, weight: .bold)
        view.translatesAutoresizingMaskIntoConstraints = false
        
        return view
    }()
    
    private let characterStatusLabel: UILabel = {
        let view = UILabel()
        
        view.font = .systemFont(ofSize: 20, weight: .medium)
        view.translatesAutoresizingMaskIntoConstraints = false
        
        return view
    }()
    
    
    private let locationHintLabel: UILabel = {
        let view = UILabel()
        
        view.text = "Last known location:"
        view.textColor = .gray
        view.font = .systemFont(ofSize: 18, weight: .medium)
        view.translatesAutoresizingMaskIntoConstraints = false
        
        return view
    }()
    
    private let locationLabel: UILabel = {
        let view = UILabel()
        
        view.font = .systemFont(ofSize: 20, weight: .medium)
        view.translatesAutoresizingMaskIntoConstraints = false
        
        return view
    }()
    
    var character: Character? {
        didSet {
            self.onCharacterChanged()
        }
    }
    
    func onCharacterChanged() {
        guard let character = self.character else { return }
        
        self.characterNameLabel.text = character.name
        self.characterStatusLabel.text = character.status + " - " + character.gender
        self.locationLabel.text = character.location.name
        
        self.apiFacade.doGet(character.imageURL()) { (data, error) in
            guard let data = data else {
                print("Failed to load image!", error)
                return
            }
            DispatchQueue.main.async {
                self.characterImageView.image = UIImage(data: data)
            }
            
        }
    }
    
    
    private func setupImage() {
        self.contentView.addSubview(self.characterImageView)
        
        self.characterImageView.leadingAnchor.constraint(equalTo: self.contentView.leadingAnchor, constant: 10).isActive = true
        self.characterImageView.topAnchor.constraint(equalTo: self.contentView.topAnchor,  constant: 10).isActive = true
        self.characterImageView.bottomAnchor.constraint(equalTo: self.contentView.bottomAnchor, constant: -10).isActive = true
        self.characterImageView.widthAnchor.constraint(equalTo: self.characterImageView.heightAnchor).isActive = true
    }
    
    private func setupNameLabel() {
        
        self.contentView.addSubview(self.characterNameLabel)
        
        self.characterNameLabel.leadingAnchor.constraint(equalTo: self.characterImageView.trailingAnchor, constant: 20).isActive = true
        self.characterNameLabel.topAnchor.constraint(equalTo: self.characterImageView.topAnchor).isActive = true

    }
    
    func setupStatusLabel() {
        self.contentView.addSubview(self.characterStatusLabel)
        
        self.characterStatusLabel.leadingAnchor.constraint(equalTo: self.characterImageView.trailingAnchor, constant: 20).isActive = true
        self.characterStatusLabel.topAnchor.constraint(equalTo: self.characterNameLabel.bottomAnchor, constant: 10).isActive = true
        
    }
    
    func setupLocationLabel() {
        self.contentView.addSubview(locationHintLabel)
        self.contentView.addSubview(locationLabel)
        
        
        self.locationHintLabel.leadingAnchor.constraint(equalTo: self.characterImageView.trailingAnchor, constant: 20).isActive = true
        self.locationHintLabel.topAnchor.constraint(equalTo: self.characterStatusLabel.bottomAnchor, constant: 20).isActive = true
        
        self.locationLabel.leadingAnchor.constraint(equalTo: self.characterImageView.trailingAnchor, constant: 20).isActive = true
        self.locationLabel.topAnchor.constraint(equalTo: self.locationHintLabel.bottomAnchor, constant: 10).isActive = true
    }
    
    private func commonInit() {
        
        self.setupImage()
        self.setupNameLabel()
        self.setupStatusLabel()
        self.setupLocationLabel()
        
    }
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        
        self.commonInit()
    }
    
    required init?(coder: NSCoder) {
        super.init(coder: coder)
        self.commonInit()
    }

}
