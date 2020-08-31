//
//  CharacterTableViewCell.swift
//  JamesEvaluation
//
//  Created by Bruno Pastre on 31/08/20.
//  Copyright © 2020 Bruno Pastre. All rights reserved.
//

import UIKit

class CharacterTableViewCell: UITableViewCell {

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
    
    
    private let firstSeenHintLabel: UILabel = {
        let view = UILabel()
        
        view.textColor = .gray
        view.font = .systemFont(ofSize: 18, weight: .medium)
        view.translatesAutoresizingMaskIntoConstraints = false
        
        return view
    }()
    
    private let firstSeenLabel: UILabel = {
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
        
        self.apiFacade.doGet(character.imageURL()) { (data, error) in
            guard let data = data else {
                print("BROW ERRO BRABO")
                return
            }
            DispatchQueue.main.async {
                self.characterImageView.image = UIImage(data: data)
                print("Data is", self.characterImageView.image)
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
        self.characterNameLabel.topAnchor.constraint(equalTo: self.contentView.topAnchor).isActive = true

    }
    
    private func commonInit() {
        
        self.setupImage()
        self.setupNameLabel()
        
    }
    
    
    
    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        
        self.commonInit()
    }
    
    required init?(coder: NSCoder) {
        super.init(coder: coder)
        self.commonInit()
    }

}
