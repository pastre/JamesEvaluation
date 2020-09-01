//
//  CharacterResponseMetadata.swift
//  JamesEvaluation
//
//  Created by Bruno Pastre on 01/09/20.
//  Copyright © 2020 Bruno Pastre. All rights reserved.
//

import Foundation

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
