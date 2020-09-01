//
//  Episode.swift
//  JamesEvaluation
//
//  Created by Bruno Pastre on 01/09/20.
//  Copyright © 2020 Bruno Pastre. All rights reserved.
//

import Foundation

struct Episode: Codable {
    var id: Int
    var name: String
    
    var air_date: String
    var episode: String
    var characters: [String]
    
    var created: String
}
