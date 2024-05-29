//
//  InstructionsView.swift
//  unit-3-project
//
//  Created by Larry Chen on 5/29/24.
//

import SwiftUI

struct InstructionsView: View {
    var body: some View {
        ScrollView {
            VStack(alignment: .leading, spacing: 20) {
                // Simple objective, big font, clean UI seen throughout app 
                Text("Objective:")
                    .customFont(.bold, 36)
                    .foregroundStyle(
                        LinearGradient(
                            gradient: Gradient(colors: [.orange.opacity(0.5), .orange]),
                            startPoint: .leading,
                            endPoint: .trailing
                        )
                    )
                
                Text("The goal of Super Tic Tac Toe is to win three smaller tic tac toe games in a row — either horizontally, vertically, or diagonally.")
                        .customFont(.regular, 24)
                
                Text("Gameplay:")
                    .customFont(.bold, 36)
                    .foregroundStyle(
                        LinearGradient(
                            gradient: Gradient(colors: [.blue.opacity(0.75), .purple]),
                            startPoint: .leading,
                            endPoint: .trailing
                        )
                    )
                
                VStack(alignment: .leading, spacing: 12) {
                    HStack(alignment: .top, spacing: 8) {
                        Text("1.")
                            .customFont(.bold, 24)
                            .foregroundColor(.orange.opacity(0.9))
                        Text("The game is played on a 3x3 grid of smaller 3x3 tic tac toe boards.")
                            .customFont(.regular, 24)
                    }
                    HStack(alignment: .top, spacing: 8) {
                        Text("2.")
                            .customFont(.bold, 24)
                            .foregroundColor(.orange.opacity(0.9))
                        Text("Players take turns placing their mark (X or O) in an empty cell of a small board.")
                            .customFont(.regular, 24)
                    }
                    HStack(alignment: .top, spacing: 8) {
                        Text("3.")
                            .customFont(.bold, 24)
                            .foregroundColor(.orange.opacity(0.9))
                        Text("The position of the player's move in a small board determines the small board that the opponent must play in next.")
                            .customFont(.regular, 24)
                    }
                    HStack(alignment: .top, spacing: 8) {
                        Text("4.")
                            .customFont(.bold, 24)
                            .foregroundColor(.orange.opacity(0.9))
                        Text("If a player wins a small board, that board is marked as won for that player.")
                            .customFont(.regular, 24)
                    }
                    HStack(alignment: .top, spacing: 8) {
                        Text("5.")
                            .customFont(.bold, 24)
                            .foregroundColor(.orange.opacity(0.9))
                        Text("If a small board is filled and no player has won, it is marked as a tie.")
                            .customFont(.regular, 24)
                    }
                    HStack(alignment: .top, spacing: 8) {
                        Text("6.")
                            .customFont(.bold, 24)
                            .foregroundColor(.orange.opacity(0.9))
                        Text("The game continues until a player wins three small boards in a row or all small boards are filled, resulting in a tie.")
                            .customFont(.regular, 24)
                    }
                }
                .padding(.horizontal, 20)

            }
            .padding(.horizontal, 30)
            .padding(.top, 20)
        }
        .navigationTitle("Instructions")
    }
}

#Preview {
    InstructionsView()
}
