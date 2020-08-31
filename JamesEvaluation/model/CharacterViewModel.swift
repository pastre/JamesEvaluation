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
    private var episodes: [Episode]?
    
    private let api = APIFacade()
    
    internal init(character: Character) {
        self.character = character
    }
    
    private func load() {
        self.api.getLocation(url: self.character.origin.url) { (location, error) in
            //TODO
        }
        
        self.api.getLocation(url: self.character.location.url) { (location, error) in
            // TODO
        }
        
        self.character.episode.forEach { (episode) in
            self.api.getEpisode(url: episode) { (episode, error) in
                //TODO
            }
        }
    }
    
    
    
    
}
