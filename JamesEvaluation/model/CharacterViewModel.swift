//
//  CharacterViewModel.swift
//  JamesEvaluation
//
//  Created by Bruno Pastre on 31/08/20.
//  Copyright © 2020 Bruno Pastre. All rights reserved.
//

import Foundation


class CharacterViewModel {
    
    private var character: Character!
    private var location, origin: Location?
    private var episodes: [Episode] = []
    
    private let api = APIFacade()
    
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
    
    
    func onUIComponentLoaded() {
        //TODO: UPDate interface
    }
    
    
    
}
