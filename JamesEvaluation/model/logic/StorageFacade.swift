//
//  StorageFacade.swift
//  JamesEvaluation
//
//  Created by Bruno Pastre on 31/08/20.
//  Copyright © 2020 Bruno Pastre. All rights reserved.
//

import Foundation

class StorageFacade {
    
    static let favoritesDidChange =  NSNotification.Name("favoritesDidChange")
    static let instance = StorageFacade()
    
    private let favoritesKey = "favorites"
    private let defaults =  UserDefaults.standard
    
    private var favorites: [Character]!
    
    private init () {
        self.favorites = self.loadFavorites()
    }
    
    func isFavorite(character: Character) -> Bool {
        return self.getFavorites().contains {
            $0 == character
        }
    }
    
    func getFavorites() -> [Character] { self.favorites }
    
    func addFavorite(character: Character) {
        self.favorites.append(character)
        NotificationCenter.default.post(name: StorageFacade.favoritesDidChange, object: nil)
        
        DispatchQueue.global().async {
            self.setFavorites()
        }
    }
    
    func removeFavorite(character: Character) {
        
        self.favorites.removeAll { (c) -> Bool in
            c == character
        }
        
        NotificationCenter.default.post(name: StorageFacade.favoritesDidChange, object: nil)
        DispatchQueue.global().async {
            self.setFavorites()
        }
    }
    
    func clearFavorites() {
        self.favorites.removeAll()
        self.setFavorites()
    }
    
    private func loadFavorites() -> [Character] {
        if let data = self.defaults.data(forKey: favoritesKey), let decoded = try? JSONDecoder().decode([Character].self, from: data) {
            return decoded
        }
        
        return []
    }
    
    private func setFavorites()  {
        guard let data = try? JSONEncoder().encode(self.favorites) else { return }
        self.defaults.set(data, forKey: self.favoritesKey)
    }
}
