//
//  Model.swift
//  JamesEvaluation
//
//  Created by Bruno Pastre on 31/08/20.
//  Copyright © 2020 Bruno Pastre. All rights reserved.
//

import UIKit

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

class Character: Codable {
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
    
    
    var loadedImage: Data?
    
    
    func createdAt() -> Date { 
        return ISO8601DateFormatter().date(from: self.created.replacingOccurrences(of: ".", with: "+"))!
    }
    
    func imageURL() -> URL { URL(string: image)!}
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
    
    static func getNearLast() -> CharacterResponseMetadata {

        CharacterResponseMetadata(count: 0, pages: 0, prev: nil, next: "https://rickandmortyapi.com/api/character/?page=190")
    }
    
    static func atPage(_ page: Int) -> CharacterResponseMetadata {
        CharacterResponseMetadata(count: 0, pages: 0, prev: nil, next: "https://rickandmortyapi.com/api/character/?page=\(page)")
    }
    
}

struct CharacterResponse: Codable {
    
    var info: CharacterResponseMetadata
    var results: [Character]
    
}
