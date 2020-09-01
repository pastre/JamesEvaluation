//
//  CharacterProvider.swift
//  JamesEvaluation
//
//  Created by Bruno Pastre on 31/08/20.
//  Copyright © 2020 Bruno Pastre. All rights reserved.
//

import Foundation


protocol CharacterProvider {
    func loadCharacters(completion: @escaping ([Character]?, Error?) -> ())
}
