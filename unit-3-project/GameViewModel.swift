//
//  GameViewModel.swift
//  unit-3-project
//
//  Created by Larry Chen on 5/28/24.
//

import SwiftUI

class GameViewModel: ObservableObject {
    @Published var game = GameModel()
    @Published var namesEntered: Bool = false

    func saveNames(playerXName: String, playerOName: String) {
        game.playerXName = playerXName
        game.playerOName = playerOName
        namesEntered = true
    }

    // Add game logic methods here
}

