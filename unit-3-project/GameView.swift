//
//  GameView.swift
//  unit-3-project
//
//  Created by Larry Chen on 5/28/24.
//

import SwiftUI


struct GameView: View {
    @EnvironmentObject var viewModel: GameViewModel
    
    var body: some View {
        VStack {
            Text("Super Tic Tac Toe Game")
                .font(.largeTitle)
                .navigationTitle("Game")
            
            // Display player names
            Text("\(viewModel.game.playerXName) (X) vs \(viewModel.game.playerOName) (O)")
                .font(.title2)
                .padding()
            
            // Game logic and UI goes here
        }
    }
}

#Preview {
    GameView()
        .environmentObject(GameViewModel())
}
