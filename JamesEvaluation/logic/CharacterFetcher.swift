//
//  CharacterLoader.swift
//  JamesEvaluation
//
//  Created by Bruno Pastre on 31/08/20.
//  Copyright © 2020 Bruno Pastre. All rights reserved.
//

import Foundation

class CharacterFetcher: CharacterProvider {
    
    var apiFacade = APIFacade()
    var currentResponse: CharacterResponseMetadata!
    var canRequest: Bool = true
    
    init() {
        self.currentResponse = CharacterResponseMetadata.getFirst()
    }
    
    func loadCharacters(completion: @escaping ([Character]?, Error?) -> ()) {
        
        guard canRequest else { return }
        
        guard let url = self.currentResponse.nextURL() else {
            completion(nil, CharacterLoaderError.noMoreCharacters)
            return
        }
        
        self.apiFacade.getCharacters(url: url) { (response, error) in
            guard let response = response else {
                DispatchQueue.main.async {
                    completion(nil, error)
                }
                return
            }
            
            self.currentResponse = response.info
            
            DispatchQueue.main.async {
                completion(response.results, error)
            }
        }
    }
    
}
