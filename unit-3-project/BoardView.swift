//
//  GameView.swift
//  unit-3-project
//
//  Created by Larry Chen on 5/28/24.
//

import SwiftUI

struct BoardView: View {
    @EnvironmentObject var viewModel: GameViewModel
    
    @State private var nextBoardRow: Int?
    @State private var nextBoardCol: Int?
    
    var body: some View {
        VStack {
            Text("Game")
                .customFont(.bold, 48)
            Text("\(viewModel.game.playerXName) (X) vs \(viewModel.game.playerOName) (O)")
                .customFont(.regular, 18)
                .padding()
            
            // Super Tic Tac Toe grid
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
                
                Button(action: {
//                    viewModel.resetGame()
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
    }
}

struct SmallGridView: View {
    @ObservedObject var viewModel: GameViewModel
    let row: Int
    let col: Int
    
    @Binding var nextBoardRow: Int?
    @Binding var nextBoardCol: Int?
    
    var body: some View {
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

struct CellView: View {
    @ObservedObject var viewModel: GameViewModel
    let bigRow: Int
    let bigCol: Int
    let smallRow: Int
    let smallCol: Int
    
    @Binding var nextBoardRow: Int?
    @Binding var nextBoardCol: Int?
    
    var body: some View {
        Button(action: {
            viewModel.makeMove(bigRow: bigRow, bigCol: bigCol, smallRow: smallRow, smallCol: smallCol)
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
        .disabled(viewModel.isCellDisabled(bigRow: bigRow, bigCol: bigCol, smallRow: smallRow, smallCol: smallCol) || (nextBoardRow != nil && (nextBoardRow != bigRow || nextBoardCol != bigCol)))
    }
}

#Preview {
    BoardView()
        .environmentObject(GameViewModel())
}
