//
//  MockCharacterCollectionViewModel.swift
//  JamesEvaluation
//
//  Created by Bruno Pastre on 01/09/20.
//  Copyright © 2020 Bruno Pastre. All rights reserved.
//

import Foundation


class MockCharacterCollectionViewModel: CharacterCollectionViewModel, CharacterLoader {
    
    func loadCharacters() {
        self.getMockedDict().forEach {
            
            let toJson = try! JSONSerialization.data(withJSONObject: $0, options: [])
            let newChar = try! JSONDecoder().decode(Character.self, from: toJson)
            
            self.characters.append(newChar)
            self.collectionView.reloadData()
        }
    }
    
    func getMockedDict() -> [[ String : Any ]] {
    
        [[String : Any]](repeating: .init(), count: 10).enumerated().map { (i, dict) -> [String : Any] in
            return [
                "id" : i,
                "name" : "Bruno \(i)",
                "image" : "",
                "url" : "",
                "created" : ISO8601DateFormatter().string(from: Date()),
                
                "status" : "Alive",
                "species" : "Developer",
                "gender" : "Male",
                
                "location" : [
                   "url": "???",
                   "name": "Swifty Seas"
               ],
                "origin": [
                    "url": "???",
                    "name": "Plains of Java"
                ],
                "episode" : [
                    "Show do Slayer, 2014",
                    "Peppers, 2016",
                    "Praca da Espanha, 2017",
                    "Apple Developer Academy, 2018"
                ]
            ]
        }
    }
    

}
