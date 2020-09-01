//
//  Location.swift
//  JamesEvaluation
//
//  Created by Bruno Pastre on 01/09/20.
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
