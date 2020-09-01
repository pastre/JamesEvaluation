//
//  CharacterManagerDelegate.swift
//  JamesEvaluation
//
//  Created by Bruno Pastre on 01/09/20.
//  Copyright © 2020 Bruno Pastre. All rights reserved.
//

import Foundation

protocol CharacterManagerDelegate: class {
    func onCharacterPicked(_ character: Character)
    func onStartLoading()
    func onDoneLoading()
}
