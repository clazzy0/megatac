//
//  GameView.swift
//  unit-3-project
//
//  Created by Larry Chen on 5/28/24.
//

import SwiftUI

struct BoardView: View {
    @EnvironmentObject var viewModel: GameViewModel
    
    // State variables to keep track of the next board position
    @State private var nextBoardRow: Int?
    @State private var nextBoardCol: Int?
    
    var body: some View {
        VStack {
            Text("Game Board")
                .customFont(.bold, 48)
                .foregroundStyle(
                    LinearGradient(
                        gradient: Gradient(colors: [.blue.opacity(0.5), .purple]),
                        startPoint: .leading,
                        endPoint: .trailing
                    )
                )
            Text("\(viewModel.game.playerXName) (X) vs \(viewModel.game.playerOName) (O)")
                .customFont(.regular, 18)
            
            // Create the Super Tic Tac Toe grid using nested ForEach loops
            VStack(spacing: 6) {
                ForEach(0..<3) { row in
                    HStack(spacing: 6) {
                        ForEach(0..<3) { col in
                            SmallGridView(viewModel: viewModel, row: row, col: col, nextBoardRow: $nextBoardRow, nextBoardCol: $nextBoardCol)
                                .border(Color.black, width: 2)
                        }
                    }
                }
            }
            .padding()
            
            // Display game over message and winner/draw result
            if viewModel.checkGameEnd() {
                Text("Game Over")
                    .customFont(.bold, 24)
                    .padding()
                
                if viewModel.checkWin(player: "X") {
                    Text("\(viewModel.game.playerXName) wins!")
                        .customFont(.regular, 20)
                } else if viewModel.checkWin(player: "O") {
                    Text("\(viewModel.game.playerOName) wins!")
                        .customFont(.regular, 20)
                } else {
                    Text("It's a draw!")
                        .customFont(.regular, 20)
                }
                
                // Button to start a new game (functionality not implemented yet)
                Button(action: {
                    viewModel.resetGame()
                    nextBoardCol = 1
                    nextBoardRow = 1
                }) {
                    Text("Play Again")
                        .customFont(.regular, 20)
                        .padding()
                        .background(Color.blue)
                        .foregroundColor(.white)
                        .cornerRadius(10)
                }
            }
            Spacer()
        }
        .padding(.top, 20)
        .background(
            LinearGradient(
                gradient: Gradient(colors: [.white, .gray.opacity(0.1)]),
                startPoint: .top,
                endPoint: .bottom
            )
            .edgesIgnoringSafeArea(.all)
        )
    }
}

struct SmallGridView: View {
    @ObservedObject var viewModel: GameViewModel
    let row: Int
    let col: Int
    
    // Binding variables to update the next board position in the parent view
    @Binding var nextBoardRow: Int?
    @Binding var nextBoardCol: Int?
    
    var body: some View {
        // Check the result of the small board
        let smallBoardResult = viewModel.checkSmallBoardWin(bigRow: row, bigCol: col)
        
        // Display the appropriate view based on the small board result
        if smallBoardResult == "X" || smallBoardResult == "O" {
            Text(smallBoardResult)
                .font(.system(size: 72))
                .foregroundColor(smallBoardResult == "X" ? .blue : .red)
                .frame(width: 120, height: 120)
                .background(nextBoardRow == row && nextBoardCol == col ? Color.yellow.opacity(0.3) : Color.clear)
        } else if smallBoardResult == "D" {
            Text("Draw")
                .font(.system(size: 24))
                .foregroundColor(.gray)
                .frame(width: 120, height: 120)
                .background(nextBoardRow == row && nextBoardCol == col ? Color.yellow.opacity(0.3) : Color.clear)
        } else {
            // Create the small grid using nested ForEach loops
            VStack(spacing: 0) {
                ForEach(0..<3) { smallRow in
                    HStack(spacing: 0) {
                        ForEach(0..<3) { smallCol in
                            CellView(viewModel: viewModel, bigRow: row, bigCol: col, smallRow: smallRow, smallCol: smallCol, nextBoardRow: $nextBoardRow, nextBoardCol: $nextBoardCol)
                                .border(Color.black, width: 1)
                        }
                    }
                }
            }
            .background(nextBoardRow == row && nextBoardCol == col ? Color.yellow.opacity(0.3) : Color.clear)
        }
    }
}

struct CellView: View {
    @ObservedObject var viewModel: GameViewModel
    let bigRow: Int
    let bigCol: Int
    let smallRow: Int
    let smallCol: Int
    
    // Binding variables to update the next board position in the parent view
    @Binding var nextBoardRow: Int?
    @Binding var nextBoardCol: Int?
    
    var body: some View {
        Button(action: {
            // Make a move when the cell is tapped
            viewModel.makeMove(bigRow: bigRow, bigCol: bigCol, smallRow: smallRow, smallCol: smallCol)
            
            // Update the next board position based on the move
            if let nextBoard = viewModel.getNextBoard(bigRow: bigRow, bigCol: bigCol, smallRow: smallRow, smallCol: smallCol) {
                nextBoardRow = nextBoard.0
                nextBoardCol = nextBoard.1
            } else {
                nextBoardRow = nil
                nextBoardCol = nil
            }
        }) {
            Text(viewModel.cellContent(bigRow: bigRow, bigCol: bigCol, smallRow: smallRow, smallCol: smallCol))
                .font(.system(size: 24))
                .foregroundColor(viewModel.cellContent(bigRow: bigRow, bigCol: bigCol, smallRow: smallRow, smallCol: smallCol) == "X" ? .blue : .red)
                .frame(width: 40, height: 40)
        }
        // Disable the cell if it's already occupied or if it's not in the allowed board
        .disabled(viewModel.isCellDisabled(bigRow: bigRow, bigCol: bigCol, smallRow: smallRow, smallCol: smallCol) || (nextBoardRow != nil && (nextBoardRow != bigRow || nextBoardCol != bigCol)))
    }
}

#Preview {
    BoardView()
        .environmentObject(GameViewModel())
}
