//
//  GameModel.swift
//  unit-3-project
//
//  Created by Larry Chen on 5/28/24.
//

import Foundation

struct GameModel {
    var playerXName: String
    var playerOName: String
    var board: [[[[String]]]]
    var currentPlayer: String
    
    init(playerXName: String = "", playerOName: String = "", board: [[[[String]]]] = Array(repeating: Array(repeating: Array(repeating: Array(repeating: "", count: 3), count: 3), count: 3), count: 3), currentPlayer: String = "X") {
        self.playerXName = playerXName
        self.playerOName = playerOName
        self.board = board
        self.currentPlayer = currentPlayer
    }
}
