//
//  GameView.swift
//  unit-3-project
//
//  Created by Larry Chen on 5/28/24.
//

import SwiftUI

struct BoardView: View {
    // Linked data
    @EnvironmentObject var viewModel: GameViewModel
    
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
                            SmallGridView(viewModel: viewModel, row: row, col: col)
                                .border(Color.black, width: 2)
                        }
                    }
                }
            }
            .padding()
        }
    }
}

struct SmallGridView: View {
    @ObservedObject var viewModel: GameViewModel
    let row: Int
    let col: Int
    
    var body: some View {
        VStack(spacing: 0) {
            ForEach(0..<3) { smallRow in
                HStack(spacing: 0) {
                    ForEach(0..<3) { smallCol in
                        CellView(viewModel: viewModel, bigRow: row, bigCol: col, smallRow: smallRow, smallCol: smallCol)
                            .border(Color.black, width: 1)
                    }
                }
            }
        }
    }
}

struct CellView: View {
    @ObservedObject var viewModel: GameViewModel
    let bigRow: Int
    let bigCol: Int
    let smallRow: Int
    let smallCol: Int
    
    var body: some View {
        Button(action: {
            viewModel.makeMove(bigRow: bigRow, bigCol: bigCol, smallRow: smallRow, smallCol: smallCol)
        }) {
            Text(viewModel.cellContent(bigRow: bigRow, bigCol: bigCol, smallRow: smallRow, smallCol: smallCol))
                .font(.system(size: 24))
                .foregroundColor(viewModel.cellContent(bigRow: bigRow, bigCol: bigCol, smallRow: smallRow, smallCol: smallCol) == "X" ? .blue : .red)
                .frame(width: 40, height: 40)
        }
        .disabled(viewModel.isCellDisabled(bigRow: bigRow, bigCol: bigCol, smallRow: smallRow, smallCol: smallCol))
    }
}

#Preview {
    BoardView()
        .environmentObject(GameViewModel())
}
