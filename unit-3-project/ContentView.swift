//
//  ContentView.swift
//  unit-3-project
//
//  Created by Larry Chen on 5/23/24.
//

import SwiftUI

// This is the initial view that a new user sees.
struct ContentView: View {
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
                .padding(.top, 60)
                
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
                    .font(.system(size: 52, weight: .bold))
                    .foregroundStyle(
                        LinearGradient(
                            gradient: Gradient(colors: [.blue, .red]),
                            startPoint: .leading,
                            endPoint: .trailing
                        )
                    )
                
                // Redesigned button with solid color, rounded corners, and shadow
                NavigationLink(destination: GameView()) {
                    Text("Start Game")
                        .customFont(.regular, 24)
                        .padding()
                        .frame(maxWidth: .infinity)
                        .background(Color.blue)
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
        }
    }
}

struct GameView: View {
    var body: some View {
        Text("Super Tic Tac Toe Game")
            .font(.largeTitle)
            .navigationTitle("Game")
    }
}

#Preview {
    ContentView()
}
