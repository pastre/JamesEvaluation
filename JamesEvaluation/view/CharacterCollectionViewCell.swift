//
//  CharacterCollectionViewCell.swift
//  JamesEvaluation
//
//  Created by Bruno Pastre on 31/08/20.
//  Copyright © 2020 Bruno Pastre. All rights reserved.
//

import UIKit

class CharacterCollectionViewCell: UICollectionViewCell {

    let apiFacade = APIFacade()
    
    var character: Character? {
        didSet {
            self.onCharacterChanged()
        }
    }
    
    private let characterImageView: UIImageView = {
        let view = UIImageView()
        
        view.translatesAutoresizingMaskIntoConstraints = false
        view.contentMode = .scaleAspectFit
        
        return view
    }()
    
    private let characterNameLabel: UILabel = {
        let view = UILabel()
        
        view.numberOfLines = 2
        view.minimumScaleFactor = 0.5
        view.adjustsFontSizeToFitWidth = true
        
        view.font = .preferredFont(forTextStyle: .title3)
        view.translatesAutoresizingMaskIntoConstraints = false
        
        return view
    }()
    
    private let characterStatusLabel: UILabel = {
        let view = UILabel()
        
        view.numberOfLines = 1
        view.minimumScaleFactor = 0.5
        view.adjustsFontSizeToFitWidth = true
        
        view.textColor = #colorLiteral(red: 0.6000000238, green: 0.6000000238, blue: 0.6000000238, alpha: 1)
        view.font = .preferredFont(forTextStyle: .body)
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
    
    
    private func onCharacterChanged() {
        guard let character = self.character else { return }
        
        self.characterNameLabel.text = character.name
        self.characterStatusLabel.text = character.status + " - " + character.gender
        self.locationLabel.text = character.location.name
        
        if let data = self.character?.loadedImage {
            self.characterImageView.image = UIImage(data: data)
            
        } else {
            self.apiFacade.doGet(character.imageURL()) { (data, error) in
                guard let data = data else {
                    print("Failed to load image!", error)
                    return
                }
                self.character?.loadedImage = data
                DispatchQueue.main.async {
                    self.characterImageView.image = UIImage(data: data)
                }
                
            }
        }
    }
    
    
    private func setupImage() {
        self.contentView.addSubview(self.characterImageView)
        
        self.characterImageView.leadingAnchor.constraint(equalTo: self.contentView.leadingAnchor).isActive = true
        self.characterImageView.topAnchor.constraint(equalTo: self.contentView.topAnchor).isActive = true
        self.characterImageView.bottomAnchor.constraint(equalTo: self.contentView.bottomAnchor).isActive = true
        self.characterImageView.widthAnchor.constraint(equalTo: self.characterImageView.heightAnchor).isActive = true
    }
    
    private func setupNameLabel() {
        
        self.contentView.addSubview(self.characterNameLabel)
        
        self.characterNameLabel.leadingAnchor.constraint(equalTo: self.characterImageView.trailingAnchor, constant: 20).isActive = true
        self.characterNameLabel.topAnchor.constraint(equalTo: self.characterImageView.topAnchor, constant: 10).isActive = true
        
        self.characterNameLabel.trailingAnchor.constraint(equalTo: self.contentView.trailingAnchor, constant: -10).isActive = true

    }
    
    private func setupStatusLabel() {
        self.contentView.addSubview(self.characterStatusLabel)
        
        self.characterStatusLabel.leadingAnchor.constraint(equalTo: self.characterImageView.trailingAnchor, constant: 20).isActive = true
        self.characterStatusLabel.topAnchor.constraint(equalTo: self.characterNameLabel.bottomAnchor).isActive = true
        
    }
    
    private func setupLocationLabel() {
        self.contentView.addSubview(locationHintLabel)
        self.contentView.addSubview(locationLabel)
        
        self.locationLabel.leadingAnchor.constraint(equalTo: self.characterImageView.trailingAnchor, constant: 20).isActive = true
        self.locationLabel.bottomAnchor.constraint(equalTo: self.contentView.bottomAnchor, constant: -10).isActive = true
        self.locationLabel.trailingAnchor.constraint(equalTo: self.contentView.trailingAnchor, constant: -10).isActive = true
        
        
        self.locationHintLabel.leadingAnchor.constraint(equalTo: self.characterImageView.trailingAnchor, constant: 20).isActive = true
        self.locationHintLabel.bottomAnchor.constraint(equalTo: self.locationLabel.topAnchor).isActive = true
        
        self.locationHintLabel.widthAnchor.constraint(equalTo: self.locationLabel.widthAnchor, multiplier: 0.5).isActive = true
        
        
    }
    
    private func commonInit() {
        self.setupImage()
        self.setupNameLabel()
        self.setupStatusLabel()
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
