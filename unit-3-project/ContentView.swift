//
//  ContentView.swift
//  unit-3-project
//
//  Created by Larry Chen on 5/23/24.
//

import SwiftUI

// This is the initial view that a new user sees.
struct ContentView: View {
    // StateObject creates the observable object
    @StateObject var viewModel = GameViewModel()
    
    var body: some View {
        NavigationView {
            VStack {
                // Center the image with padding and shadow for a more modern look
                HStack {
                    Spacer()
                    Image("super-ttt")
                        .resizable()
                        .aspectRatio(contentMode: .fit)
                        .frame(width: 350, height: 350)
                        .shadow(color: .gray, radius: 10, x: 0, y: 10)
                    Spacer()
                }
                
                // Make "Super" text pop with a larger font size and gradient
                Text("Super")
                    .customFont(.bold, 60)
                    .foregroundStyle(
                        LinearGradient(
                            gradient: Gradient(colors: [.yellow, .orange]),
                            startPoint: .top,
                            endPoint: .bottom
                        )
                    )
                    .padding(.top, 20)
                
                // "Tic Tac Toe" text with a gradient and more subtle shadow
                Text("Tic Tac Toe")
                    .customFont(.bold, 52)
                // Make letters stick together more
                    .tracking(-1)
                    .foregroundStyle(
                        LinearGradient(
                            gradient: Gradient(colors: [.blue, .red]),
                            startPoint: .leading,
                            endPoint: .trailing
                        )
                    )
                
                // Redesigned button with solid color, rounded corners, and shadow, passed down the viewModel / data in the app
                NavigationLink(destination: NameEntryView(viewModel: viewModel)) {
                    Text("Start Game")
                        .customFont(.regular, 24)
                        .padding(.vertical, 24)
                        .frame(maxWidth: .infinity)
                        .background(Color.black.opacity(0.8))
                        .foregroundColor(.white)
                        .cornerRadius(15)
                        .shadow(color: .gray, radius: 5, x: 0, y: 5)
                }
                .padding(.horizontal, 30)
                
                Spacer()
            }
            // Small design decision
            .background(
                LinearGradient(
                    gradient: Gradient(colors: [.white, .gray.opacity(0.1)]),
                    startPoint: .top,
                    endPoint: .bottom
                )
                .edgesIgnoringSafeArea(.all)
            )
            .padding(.top, 60)
        }
    }
}

#Preview {
    ContentView()
}
