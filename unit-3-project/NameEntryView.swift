//
//  NameEntryView.swift
//  unit-3-project
//
//  Created by Larry Chen on 5/28/24.
//

import SwiftUI

struct NameEntryView: View {
    // The data that is linked, using observed object because
    @ObservedObject var viewModel: GameViewModel
    
    var body: some View {
        VStack(alignment: .leading, spacing: 20) {
            // Using consistent color styles
            Text("Enter Names")
                .customFont(.bold, 48)
                .foregroundStyle(
                    LinearGradient(
                        gradient: Gradient(colors: [.orange.opacity(0.5), .orange]),
                        startPoint: .leading,
                        endPoint: .trailing
                    )
                )
            
            // Headline + TextField
            VStack(alignment: .leading, spacing: 10) {
                Text("Player X")
                    .customFont(.medium, 18)
                TextField("Enter name for X", text: $viewModel.game.playerXName)
                    .padding(.horizontal, 20)
                    .padding(.vertical, 20)
                    .font(.system(size: 24))
                    .background(Color.gray.opacity(0.2))
                    .cornerRadius(10)
            }
            
            // Headline + TextField
            VStack(alignment: .leading, spacing: 10) {
                Text("Player O")
                    .customFont(.medium, 18)
                TextField("Enter name for O", text: $viewModel.game.playerOName)
                    .padding(.horizontal, 20)
                    .padding(.vertical, 20)
                    .font(.system(size: 24))
                    .background(Color.gray.opacity(0.2))
                    .cornerRadius(10)
            }
            
            NavigationLink(destination: BoardView().environmentObject(viewModel)) {
                Text("Play")
                // Similar button UI
                    .customFont(.regular, 24)
                    .padding(.vertical, 24)
                    .frame(maxWidth: .infinity)
                // Visually displays the user cannot continue without inputting a username
                    .background(viewModel.game.playerXName.isEmpty || viewModel.game.playerOName.isEmpty ? Color.black.opacity(0.5) : Color.black.opacity(0.8))
                    .foregroundColor(.white)
                    .cornerRadius(15)
                    .shadow(color: .gray, radius: 5, x: 0, y: 5)
            }
            // Checks whether both fields are filled in or not
            .disabled(viewModel.game.playerXName.isEmpty || viewModel.game.playerOName.isEmpty)
            
            Spacer()
        }
        .padding(.top, 30)
        .padding(.horizontal, 30)
        // For consistent UI theme
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

#Preview {
    NameEntryView(viewModel: GameViewModel())
}
