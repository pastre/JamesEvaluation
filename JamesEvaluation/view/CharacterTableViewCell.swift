//
//  CharacterTableViewCell.swift
//  JamesEvaluation
//
//  Created by Bruno Pastre on 31/08/20.
//  Copyright © 2020 Bruno Pastre. All rights reserved.
//

import UIKit

class CharacterTableViewCell: UITableViewCell {

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
    
    
    private func setupImage() {
        self.contentView.addSubview(self.characterImageView)
        
        self.characterImageView.leadingAnchor.constraint(equalTo: self.contentView.leadingAnchor).isActive = true
        self.characterImageView.topAnchor.constraint(equalTo: self.contentView.topAnchor).isActive = true
        self.characterImageView.bottomAnchor.constraint(equalTo: self.contentView.bottomAnchor).isActive = true
        self.characterImageView.widthAnchor.constraint(equalTo: self.contentView.widthAnchor, multiplier: 0.3).isActive = true
    }
    
    private func setupNameLabel() {
        
        self.contentView.addSubview(self.characterNameLabel)
        
        self.characterNameLabel.leadingAnchor.constraint(equalTo: self.imageView!.trailingAnchor, constant: 20).isActive = true
        self.characterNameLabel.topAnchor.constraint(equalTo: self.contentView.topAnchor).isActive = true

    }
    
    private func commonInit() {
        
        self.setupImage()
        
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
