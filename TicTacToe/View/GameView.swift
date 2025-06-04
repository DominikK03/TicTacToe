//
//  GameBoardView.swift
//  TicTacToe
//
//  Created by Dominik on 28/05/2025.
//

import SwiftUI
import CoreData

struct GameView: View {
    let players: [Player]
    @State var board: Board
    let game: Game
    let context: NSManagedObjectContext
    var onBack: () -> Void
    var onRestart: () -> Void
    @StateObject private var viewModel: GameViewModel
    @State private var showTakenAlert = false
    @State private var shakeTrigger: CGFloat = 0
    
    init(players: [Player], board: Board, game: Game, context: NSManagedObjectContext, onBack: @escaping () -> Void, onRestart: @escaping () -> Void) {
        self.players = players
        self._board = State(initialValue: board)
        self.game = game
        self.context = context
        self.onBack = onBack
        self.onRestart = onRestart
        _viewModel = StateObject(wrappedValue: GameViewModel(context: context, players: players, board: board, game: game))
    }
    
    var body: some View {
        ZStack {
            LinearGradient(gradient: Gradient(colors: [Color.blue.opacity(0.2), Color.purple.opacity(0.2)]),
                           startPoint: .topLeading,
                           endPoint: .bottomTrailing)
                .ignoresSafeArea()
            VStack(spacing: 30) {
                HStack {
                    Button(action: onBack) {
                        Image(systemName: "chevron.left")
                            .font(.title2)
                            .foregroundColor(.purple)
                    }
                    Spacer()
                }
                .padding(.horizontal)
                Text("Tic Tac Toe")
                    .font(.system(size: 40, weight: .bold, design: .rounded))
                    .foregroundStyle(LinearGradient(
                        colors: [.blue, .purple],
                        startPoint: .leading,
                        endPoint: .trailing
                    ))
                    .shadow(color: .gray.opacity(0.3), radius: 5, x: 0, y: 5)
                Text("Teraz gra: \(viewModel.currentPlayer.name)")
                    .font(.title2)
                    .foregroundColor(.purple)
                    .bold()
                LazyVGrid(columns: Array(repeating: GridItem(.flexible(), spacing: 15), count: 3), spacing: 15) {
                    ForEach(0..<9, id: \ .self) { index in
                        let row = index / 3
                        let col = index % 3
                        ZStack {
                            RoundedRectangle(cornerRadius: 15)
                                .fill(Color.white.opacity(0.7))
                                .shadow(color: .gray.opacity(0.3), radius: 5, x: 0, y: 5)
                            Text(viewModel.board.board[row][col].player ?? "")
                                .font(.system(size: 50, weight: .bold))
                                .foregroundStyle(LinearGradient(
                                    colors: [.blue, .purple],
                                    startPoint: .leading,
                                    endPoint: .trailing
                                ))
                        }
                        .aspectRatio(1, contentMode: .fit)
                        .onTapGesture {
                            if viewModel.isMoveAvailable(row: row, col: col) {
                                viewModel.handleTap(row: row, col: col)
                            } else {
                                withAnimation(.default) {
                                    shakeTrigger += 1
                                }
                                showTakenAlert = true
                            }
                        }
                    }
                }
                .padding(.horizontal, 20)
                .modifier(ShakeEffect(animatableData: shakeTrigger))
                if viewModel.gameOver {
                    VStack {
                        Text(viewModel.winner.isEmpty ? "Remis!" : "Wygrał: \(viewModel.winner)!")
                            .font(.title)
                            .foregroundColor(.purple)
                            .bold()
                        Button(action: onRestart) {
                            CustomText(title: "Zagraj ponownie", icon: "arrow.clockwise")
                        }
                    }
                }
                Spacer()
            }
            .padding()
        }
        .alert(isPresented: $showTakenAlert) {
            Alert(title: Text("To pole jest zajęte"))
        }
    }
}

#Preview {
    let context = PersistenceController.preview.container.viewContext
    let player1 = Player(name: "A", chosenSymbol: .CROSS)
    let player2 = Player(name: "B", chosenSymbol: .CIRCLE)
    let game = Game(context: context, firstPlayer: "A", secondPlayer: "B")
    var board = Board(board: [])
    board.initBoard(context: context, game: game)
    return GameView(players: [player1, player2], board: board, game: game, context: context, onBack: {}, onRestart: {})
}
