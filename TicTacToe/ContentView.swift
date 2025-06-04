//
//  ContentView.swift
//  TicTacToe
//
//  Created by Dominik on 27/05/2025.
//

import SwiftUI
import CoreData

enum AppScreen {
    case mainMenu
    case playerNames
    case game(players: [Player], board: Board, game: Game)
    case history
}

struct ContentView: View {
    @Environment(\.managedObjectContext) private var viewContext
    @State private var currentScreen: AppScreen = .mainMenu
    @State private var players: [Player] = []
    @State private var board = Board(board: [])
    @State private var game: Game? = nil
    @State private var gameID = UUID()
    
    var body: some View {
        ZStack {
            switch currentScreen {
            case .mainMenu:
                MainMenuView(
                    onStartGame: {
                        currentScreen = .playerNames
                    },
                    onShowHistory: {
                        currentScreen = .history
                    }
                )
            case .playerNames:
                PlayerNamesView(
                    onStart: { players, board, game in
                        self.players = players
                        self.board = board
                        self.game = game
                        currentScreen = .game(players: players, board: board, game: game)
                    },
                    onBack: {
                        currentScreen = .mainMenu
                    },
                    context: viewContext
                )
            case .game(let players, let board, let game):
                GameView(
                    players: players,
                    board: board,
                    game: game,
                    context: viewContext,
                    onBack: {
                        currentScreen = .mainMenu
                    },
                    onRestart: {
                        // Create new game and board
                        let newGame = Game(context: viewContext, firstPlayer: players[0].name, secondPlayer: players[1].name)
                        var newBoard = Board(board: [])
                        newBoard.initBoard(context: viewContext, game: newGame)
                        self.board = newBoard
                        self.game = newGame
                        self.gameID = UUID()
                        currentScreen = .game(players: players, board: newBoard, game: newGame)
                    }
                )
                .id(gameID)
            case .history:
                GameHistoryView(
                    viewModel: GameHistoryViewModel(context: viewContext),
                    onBack: {
                        currentScreen = .mainMenu
                    }
                )
            }
        }
    }
}

#Preview {
    ContentView().environment(\.managedObjectContext, PersistenceController.preview.container.viewContext)
}
