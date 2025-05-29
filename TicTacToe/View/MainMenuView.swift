//
//  MainMenuView.swift
//  TicTacToe
//
//  Created by Dominik on 28/05/2025.
//

import SwiftUI

struct MainMenuView: View {
    var body: some View {
            NavigationStack {
                ZStack {
                    LinearGradient(gradient: Gradient(colors: [Color.blue.opacity(0.2), Color.purple.opacity(0.2)]),
                                   startPoint: .topLeading,
                                   endPoint: .bottomTrailing)
                        .ignoresSafeArea()
                    
                    VStack(spacing: 40) {
                        Text("Tic Tac Toe")
                            .font(.system(size: 50, weight: .bold, design: .rounded))
                            .foregroundStyle(LinearGradient(
                                colors: [.blue, .purple],
                                startPoint: .leading,
                                endPoint: .trailing
                            ))
                            .shadow(color: .gray.opacity(0.3), radius: 5, x: 0, y: 5)
                        
                        Spacer()
                        
                        VStack(spacing: 20) {
                            NavigationLink(destination: PlayerNamesView()) {
                                CustomText(title: "Graj", icon: "gamecontroller")
                            }
                            
                            NavigationLink(destination: GameHistoryView()) {
                                CustomText(title: "Historia Gier", icon: "clock.arrow.circlepath")
                            }
                        }
                        .padding(.horizontal, 20)
                        
                        Spacer()
                        
                        VStack {
                            Text("Mateusz Kędra")
                                .font(.caption)
                                .foregroundColor(.gray)
                                .padding(.bottom, 5)
                            Text("Dominik Kępczyk")
                                .font(.caption)
                                .foregroundColor(.gray)
                        }
                    }
                    .padding()
                }
            }
        }
}


#Preview {
    MainMenuView()
}
