//
//  GameViewModel.swift
//  unit-3-project
//
//  Created by Larry Chen on 5/28/24.
//

import Foundation

class GameViewModel: ObservableObject {
    @Published var game = GameModel()
    @Published var namesEntered: Bool = false
    @Published var isGameBoardDisabled: Bool = false // Add this line
    
    func saveNames(playerXName: String, playerOName: String) {
        game.playerXName = playerXName
        game.playerOName = playerOName
        namesEntered = true
    }
    
    // Basic move logic for the Tic Tac Toe game
    func makeMove(bigRow: Int, bigCol: Int, smallRow: Int, smallCol: Int) {
        // Ensure the move is valid and the cell is empty
        if game.board[bigRow][bigCol][smallRow][smallCol] == "" {
            game.board[bigRow][bigCol][smallRow][smallCol] = game.currentPlayer
            game.currentPlayer = (game.currentPlayer == "X") ? "O" : "X"
            
            // Update isGameBoardDisabled based on the game state
            isGameBoardDisabled = checkGameEnd() // Implement the checkGameEnd() function
        }
    }
    
    func cellContent(bigRow: Int, bigCol: Int, smallRow: Int, smallCol: Int) -> String {
        return game.board[bigRow][bigCol][smallRow][smallCol]
    }
    
    func isCellDisabled(bigRow: Int, bigCol: Int, smallRow: Int, smallCol: Int) -> Bool {
        return game.board[bigRow][bigCol][smallRow][smallCol] != ""
    }
    
    // Implement this function to check if the game has ended
    func checkGameEnd() -> Bool {
        // Add your logic here to determine if the game has ended
        // Return true if the game has ended, false otherwise
        return false
    }
}
