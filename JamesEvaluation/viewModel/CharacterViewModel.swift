//
//  CharacterViewModel.swift
//  JamesEvaluation
//
//  Created by Bruno Pastre on 31/08/20.
//  Copyright © 2020 Bruno Pastre. All rights reserved.
//

import Foundation

protocol CharacterViewModelDelegate: class {
    func updateInterface()
}

class CharacterViewModel {
    
    private var location, origin: Location?
    private var episodes: [Episode] = []
    
    private let api = APIFacade()
    private let storage = StorageFacade.instance
    
    var delegate: CharacterViewModelDelegate?
    var character: Character!
    
    internal init(character: Character) {
        self.character = character
    }
    
    private func load() {
        self.api.getLocation(url: self.character.origin.url) { (location, error) in
            guard let location = location else {
                print("Failed to fetch origin location!", error)
                return
            }
            
            self.location = location
            self.onUIComponentLoaded()
        }
        
        self.api.getLocation(url: self.character.location.url) { (location, error) in
            guard let location = location else {
                print("Failed to fetch current location!", error)
                return
            }
            
            self.location = location
            self.onUIComponentLoaded()
        }
        
        self.character.episode.forEach { (url) in
            self.api.getEpisode(url: url) { (episode, error) in
                guard let episode = episode else {
                    print("Failed to fetch episode!", error)
                    return
                }
                self.episodes.append(episode)
                self.onUIComponentLoaded()
            }
        }
    }
    
    func onFavorite() {
        
        if self.isFavorite() {
            self.storage.removeFavorite(character: self.character)
        } else {
            self.storage.addFavorite(character: self.character)
        }
    }
    
    func onUIComponentLoaded() {
        self.delegate?.updateInterface()
    }
    
    func getSpecies() -> String {
    self.unpackUnknown(value: self.character.species, name: "Species") }
    
    func getGender() -> String {
        self.unpackUnknown(value: self.character.gender, name: "Gender")
    }
    
    func isFavorite() -> Bool { self.storage.isFavorite(character: self.character) }
    
    func getStatus() -> String {
        
        self.unpackUnknown(value: self.character.status, name: "Status")
    }
    
    func unpackUnknown(value: String, name: String) -> String {
     value == "unknown" ? "Unknown \(name)" : value}
    
    
}
