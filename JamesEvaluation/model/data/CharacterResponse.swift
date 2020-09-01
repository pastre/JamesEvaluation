//
//  CharacterResponse.swift
//  JamesEvaluation
//
//  Created by Bruno Pastre on 31/08/20.
//  Copyright © 2020 Bruno Pastre. All rights reserved.
//

import Foundation

struct CharacterResponse: Codable {
    
    var info: CharacterResponseMetadata
    var results: [Character]
    
}
