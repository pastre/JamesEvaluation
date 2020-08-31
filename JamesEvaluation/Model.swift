//
//  Model.swift
//  JamesEvaluation
//
//  Created by Bruno Pastre on 31/08/20.
//  Copyright © 2020 Bruno Pastre. All rights reserved.
//

import Foundation

struct Location {
    
    var id: Int
    var name: String
    var type: String
    var dimension: String
    var residents: [String]
    var url: String
    var created: String
    
}

struct Episode {
    var id: Int
    var name: String
    
    var air_date: String
    var episode: String
    var characters: [String]
    
    var created: String
}

struct Character {
    var id: Int
    var name: String
    var image: String
    var url: String
    var created: String
    
    var status: String
    var species: String
    var gender: String
    
    var location: Location
    var episode: [Episode]
}
