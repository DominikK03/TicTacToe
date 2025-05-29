//
//  BoardViewModel.swift
//  TicTacToe
//
//  Created by Dominik on 29/05/2025.
//

import Foundation
import CoreData

class BoardViewModel : ObservableObject {
    @Published private var board : Board
    private let context : NSManagedObjectContext!
    private let game : Game!
    
    
    init(board: Board, context: NSManagedObjectContext, game: Game) {
        self.context = context
        self.game = game
        self.board = board
        self.board.initBoard(context: context, game: game)
    }

    public func setMoveOnBoard(move: Move) {
        self.board.board[Int(move.row)][Int(move.col)] = move
    }
    
    public func isMoveAvailable(row: Int, col: Int) -> Bool {
        return board.board[row][col].player == ""
    }
    
    public func flushField(row: Int, col: Int) {
        let emptyField = Move(context: context, row: Int16(row), col: Int16(col), player: "", toGame: game)
        board.board[row][col] = emptyField
    }
}

