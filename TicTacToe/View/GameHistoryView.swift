//
//  GameHistoryView.swift
//  TicTacToe
//
//  Created by Dominik on 28/05/2025.
//

import SwiftUI
import CoreData

struct GameHistoryView: View {
    @ObservedObject var viewModel: GameHistoryViewModel
    var onBack: () -> Void
    @State private var selectedGame: Game? = nil
    var body: some View {
        ZStack {
            LinearGradient(gradient: Gradient(colors: [Color.blue.opacity(0.2), Color.purple.opacity(0.2)]),
                           startPoint: .topLeading,
                           endPoint: .bottomTrailing)
                .ignoresSafeArea()
            VStack {
                HStack {
                    Button(action: onBack) {
                        Image(systemName: "chevron.left")
                            .font(.title2)
                            .foregroundColor(.purple)
                    }
                    Spacer()
                    Menu {
                        Button(role: .destructive, action: {
                            viewModel.deleteAllGames()
                        }) {
                            Label("Usuń wszystkie gry", systemImage: "trash")
                        }
                    } label: {
                        Image(systemName: "ellipsis.circle")
                            .font(.title2)
                            .foregroundColor(.purple)
                    }
                }
                .padding(.horizontal)
                Text("Historia Gier")
                    .font(.system(size: 30, weight: .bold, design: .rounded))
                    .foregroundStyle(LinearGradient(
                        colors: [.blue, .purple],
                        startPoint: .leading,
                        endPoint: .trailing
                    ))
                    .shadow(color: .gray.opacity(0.3), radius: 5, x: 0, y: 5)
                List {
                    ForEach(viewModel.games) { game in
                        VStack(alignment: .leading, spacing: 4) {
                            Text("\(game.firstPlayer ?? "") vs \(game.secondPlayer ?? "")")
                                .font(.headline)
                            Text("Wynik: \(game.result ?? "")")
                                .font(.subheadline)
                                .foregroundColor(.gray)
                        }
                        .padding(.vertical, 4)
                        .onTapGesture {
                            selectedGame = game
                        }
                    }
                    .onDelete(perform: viewModel.deleteGames)
                }
                .listStyle(.plain)
            }
            .padding(.top)
        }
        .sheet(item: $selectedGame) { game in
            PlayedGameView(viewModel: PlayedGameViewModel(game: game, context: viewModel.context), onBack: { selectedGame = nil })
        }
    }
}

#Preview {
    let context = PersistenceController.preview.container.viewContext
    let viewModel = GameHistoryViewModel(context: context)
    return GameHistoryView(viewModel: viewModel, onBack: {})
}
