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
        // Check if any player has won the game
        if checkWin(player: "X") || checkWin(player: "O") {
            return true
        }
        
        // Check if the game is a draw (all cells filled)
        for bigRow in 0..<3 {
            for bigCol in 0..<3 {
                for smallRow in 0..<3 {
                    for smallCol in 0..<3 {
                        if game.board[bigRow][bigCol][smallRow][smallCol] == "" {
                            return false
                        }
                    }
                }
            }
        }
        
        return true
    }

    func checkWin(player: String) -> Bool {
        // Check for wins in each big row
        for bigRow in 0..<3 {
            if checkBigRowWin(bigRow: bigRow, player: player) {
                return true
            }
        }
        
        // Check for wins in each big column
        for bigCol in 0..<3 {
            if checkBigColWin(bigCol: bigCol, player: player) {
                return true
            }
        }
        
        // Check for wins in the two big diagonals
        if checkBigDiagonalWin(player: player) {
            return true
        }
        
        return false
    }

    func checkBigRowWin(bigRow: Int, player: String) -> Bool {
        for smallRow in 0..<3 {
            if game.board[bigRow][0][smallRow][0] == player &&
               game.board[bigRow][1][smallRow][1] == player &&
               game.board[bigRow][2][smallRow][2] == player {
                return true
            }
        }
        return false
    }

    func checkBigColWin(bigCol: Int, player: String) -> Bool {
        for smallCol in 0..<3 {
            if game.board[0][bigCol][0][smallCol] == player &&
               game.board[1][bigCol][1][smallCol] == player &&
               game.board[2][bigCol][2][smallCol] == player {
                return true
            }
        }
        return false
    }

    func checkBigDiagonalWin(player: String) -> Bool {
        // Check the top-left to bottom-right diagonal
        if game.board[0][0][0][0] == player &&
           game.board[1][1][1][1] == player &&
           game.board[2][2][2][2] == player {
            return true
        }
        
        // Check the top-right to bottom-left diagonal
        if game.board[0][2][0][2] == player &&
           game.board[1][1][1][1] == player &&
           game.board[2][0][2][0] == player {
            return true
        }
        
        return false
    }

    func getNextBoard(bigRow: Int, bigCol: Int, smallRow: Int, smallCol: Int) -> (Int, Int)? {
        // Check if the mini board at the next position is available
        if isBoardAvailable(bigRow: smallRow, bigCol: smallCol) {
            return (smallRow, smallCol)
        }
        
        // If the mini board is not available, allow the player to choose any available board
        for bigRow in 0..<3 {
            for bigCol in 0..<3 {
                if isBoardAvailable(bigRow: bigRow, bigCol: bigCol) {
                    return (bigRow, bigCol)
                }
            }
        }
        
        return nil
    }

    func isBoardAvailable(bigRow: Int, bigCol: Int) -> Bool {
        for smallRow in 0..<3 {
            for smallCol in 0..<3 {
                if game.board[bigRow][bigCol][smallRow][smallCol] == "" {
                    return true
                }
            }
        }
        return false
    }
}
