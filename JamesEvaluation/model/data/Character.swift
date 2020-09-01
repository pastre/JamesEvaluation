//
//  Character.swift
//  JamesEvaluation
//
//  Created by Bruno Pastre on 01/09/20.
//  Copyright © 2020 Bruno Pastre. All rights reserved.
//

import Foundation

class Character: Codable, Equatable {
    static func == (lhs: Character, rhs: Character) -> Bool {
        lhs.id == rhs.id
    }
    
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
