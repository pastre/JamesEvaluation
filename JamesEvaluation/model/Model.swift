//
//  Model.swift
//  JamesEvaluation
//
//  Created by Bruno Pastre on 31/08/20.
//  Copyright © 2020 Bruno Pastre. All rights reserved.
//

import Foundation

struct Location: Codable {
    
    var id: Int
    var name: String
    var type: String
    var dimension: String
    var residents: [String]
    var url: String
    var created: String
    
}

struct Episode: Codable {
    var id: Int
    var name: String
    
    var air_date: String
    var episode: String
    var characters: [String]
    
    var created: String
}

struct CharacterLocation: Codable {
    var name, url: String
}

struct Character: Codable {
    var id: Int
    var name: String
    var image: String
    var url: String
    var created: String
    
    var status: String
    var species: String
    var gender: String
    
    var location, origin: CharacterLocation
    var episode: [String]
}

struct CharacterResponseMetadata: Codable {
    
    
    var count, pages: Int
    var prev, next: String?
    
    func nextURL() -> URL? {
        if let next = self.next { return URL(string: next) }
        return nil
    }
    
    static func getFirst() ->  CharacterResponseMetadata {
         CharacterResponseMetadata(count: 0, pages: 0, prev: nil, next: "https://rickandmortyapi.com/api/character/")
    }
    
}

struct CharacterResponse: Codable {
    
    var info: CharacterResponseMetadata
    var results: [Character]
    
}
