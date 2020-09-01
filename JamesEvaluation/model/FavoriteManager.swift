//
//  FavoriteManager.swift
//  JamesEvaluation
//
//  Created by Bruno Pastre on 31/08/20.
//  Copyright © 2020 Bruno Pastre. All rights reserved.
//

import Foundation

class StorageFacade {
    
    private let favoritesKey = "favorites"
    private let defaults =  UserDefaults.standard
    
    func isFavorite(character: Character) -> Bool {
        return self.getFavorites().contains {
            $0 == character
        }
    }
    
    func getFavorites() -> [Character] {
        if let data = self.defaults.data(forKey: favoritesKey), let decoded = try? JSONDecoder().decode([Character].self, from: data) {
            return decoded
        }
        
        return []
    }
    
    func setFavorites(to newValue: [Character] )  {
        guard let data = try? JSONEncoder().encode(newValue) else { return }
        self.defaults.set(data, forKey: self.favoritesKey)
    }
}
