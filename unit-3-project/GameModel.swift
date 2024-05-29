//
//  GameModel.swift
//  unit-3-project
//
//  Created by Larry Chen on 5/28/24.
//

import Foundation

struct GameModel {
    var playerXName: String = ""
    var playerOName: String = ""
    var board: [[String]] = Array(repeating: Array(repeating: "", count: 3), count: 3)
    var currentPlayer: String = "X"
    // Add other game-related data as needed
}
