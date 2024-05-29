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
                        .frame(width: 330, height: 330)
                        .shadow(color: .gray, radius: 10, x: 0, y: 10)
                    Spacer()
                }
                
                // Make "Super" text pop with a larger font size and gradient
                Text("Super")
                    .customFont(.bold, 56)
                    .foregroundStyle(
                        LinearGradient(
                            gradient: Gradient(colors: [.yellow, .orange]),
                            startPoint: .top,
                            endPoint: .bottom
                        )
                    )
                
                // "Tic Tac Toe" text with a gradient and more subtle shadow
                Text("Tic Tac Toe")
                    .customFont(.bold, 48)
                // Make letters stick together more
                    .tracking(-1)
                    .foregroundStyle(
                        LinearGradient(
                            gradient: Gradient(colors: [.blue.opacity(0.75), .purple]),
                            startPoint: .leading,
                            endPoint: .trailing
                        )
                    )
                
                // Redesigned button with solid color, rounded corners, and shadow, passed down the viewModel / data in the app
                NavigationLink(destination: NameEntryView(viewModel: viewModel)) {
                    Text("Start Game")
                        .customFont(.regular, 24)
                        .padding(.vertical, 22)
                        .frame(maxWidth: .infinity)
                        .background(Color.black.opacity(0.9))
                        .foregroundColor(.white)
                        .cornerRadius(15)
                }
                .padding(.horizontal, 30)
                .padding(.top, -5)
                // View for giving instructions, per usability testing feedback
                NavigationLink(destination: InstructionsView()) {
                    HStack {
                        Image(systemName: "book.fill")
                            .font(.system(size: 20))
                            .foregroundColor(.white)
                        
                        Text("Guide")
                            .customFont(.regular, 20)
                            .foregroundColor(.white)
                    }
                    .padding(.vertical, 14)
                    .frame(maxWidth: .infinity)
                    .background(Color.navy.opacity(0.8))
                    .cornerRadius(15)
                    
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
            .padding(.top, 50)
        }
    }
}

// Define a custom color for navy
extension Color {
    static let navy = Color(red: 0.0, green: 0.0, blue: 0.15)
}

#Preview {
    ContentView()
}
