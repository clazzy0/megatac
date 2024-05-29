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
        if checkSmallBoardWin(bigRow: bigRow, bigCol: 0) == player &&
            checkSmallBoardWin(bigRow: bigRow, bigCol: 1) == player &&
            checkSmallBoardWin(bigRow: bigRow, bigCol: 2) == player {
            return true
        }
        return false
    }
    
    func checkBigColWin(bigCol: Int, player: String) -> Bool {
        if checkSmallBoardWin(bigRow: 0, bigCol: bigCol) == player &&
            checkSmallBoardWin(bigRow: 1, bigCol: bigCol) == player &&
            checkSmallBoardWin(bigRow: 2, bigCol: bigCol) == player {
            return true
        }
        return false
    }
    
    func checkBigDiagonalWin(player: String) -> Bool {
        // Check the top-left to bottom-right diagonal
        if checkSmallBoardWin(bigRow: 0, bigCol: 0) == player &&
            checkSmallBoardWin(bigRow: 1, bigCol: 1) == player &&
            checkSmallBoardWin(bigRow: 2, bigCol: 2) == player {
            return true
        }
        
        // Check the top-right to bottom-left diagonal
        if checkSmallBoardWin(bigRow: 0, bigCol: 2) == player &&
            checkSmallBoardWin(bigRow: 1, bigCol: 1) == player &&
            checkSmallBoardWin(bigRow: 2, bigCol: 0) == player {
            return true
        }
        
        return false
    }
    
    func checkSmallBoardWin(bigRow: Int, bigCol: Int) -> String {
        // Check rows
        for smallRow in 0..<3 {
            if game.board[bigRow][bigCol][smallRow][0] != "" &&
                game.board[bigRow][bigCol][smallRow][0] == game.board[bigRow][bigCol][smallRow][1] &&
                game.board[bigRow][bigCol][smallRow][1] == game.board[bigRow][bigCol][smallRow][2] {
                return game.board[bigRow][bigCol][smallRow][0]
            }
        }
        
        // Check columns
        for smallCol in 0..<3 {
            if game.board[bigRow][bigCol][0][smallCol] != "" &&
                game.board[bigRow][bigCol][0][smallCol] == game.board[bigRow][bigCol][1][smallCol] &&
                game.board[bigRow][bigCol][1][smallCol] == game.board[bigRow][bigCol][2][smallCol] {
                return game.board[bigRow][bigCol][0][smallCol]
            }
        }
        
        // Check diagonals
        if game.board[bigRow][bigCol][0][0] != "" &&
            game.board[bigRow][bigCol][0][0] == game.board[bigRow][bigCol][1][1] &&
            game.board[bigRow][bigCol][1][1] == game.board[bigRow][bigCol][2][2] {
            return game.board[bigRow][bigCol][0][0]
        }
        
        if game.board[bigRow][bigCol][0][2] != "" &&
            game.board[bigRow][bigCol][0][2] == game.board[bigRow][bigCol][1][1] &&
            game.board[bigRow][bigCol][1][1] == game.board[bigRow][bigCol][2][0] {
            return game.board[bigRow][bigCol][0][2]
        }
        
        // Check if the small board is fully filled (draw)
        for smallRow in 0..<3 {
            for smallCol in 0..<3 {
                if game.board[bigRow][bigCol][smallRow][smallCol] == "" {
                    return ""
                }
            }
        }
        
        return "D" // Draw
    }
    
    func getNextBoard(bigRow: Int, bigCol: Int, smallRow: Int, smallCol: Int) -> (Int, Int)? {
        // Check if the mini board at the next position is available and not already won
        if isBoardAvailable(bigRow: smallRow, bigCol: smallCol) && checkSmallBoardWin(bigRow: smallRow, bigCol: smallCol) == "" {
            return (smallRow, smallCol)
        }
        
        // If the mini board is not available or already won, allow the player to choose any available board
        for bigRow in 0..<3 {
            for bigCol in 0..<3 {
                if isBoardAvailable(bigRow: bigRow, bigCol: bigCol) && checkSmallBoardWin(bigRow: bigRow, bigCol: bigCol) == "" {
                    return (bigRow, bigCol)
                }
            }
        }
        
        return nil
    }
    
    func isBoardAvailable(bigRow: Int, bigCol: Int) -> Bool {
        // Check if the small board is not yet won or drawn
        if checkSmallBoardWin(bigRow: bigRow, bigCol: bigCol) != "" {
            return false
        }
        
        // Check if the small board has any empty cells
        for smallRow in 0..<3 {
            for smallCol in 0..<3 {
                if game.board[bigRow][bigCol][smallRow][smallCol] == "" {
                    return true
                }
            }
        }
        
        return false
    }
    
    func resetGame() -> Void {
        game = GameModel(playerXName: game.playerXName, playerOName: game.playerOName)
    }
}
