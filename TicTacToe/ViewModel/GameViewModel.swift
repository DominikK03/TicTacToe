//
//  GameViewModel.swift
//  TicTacToe
//
//  Created by Dominik on 29/05/2025.
//

import Foundation
import CoreData


class GameViewModel {
    @Published var players : [Player]
    @Published var currentPlayer: Player!
    private let boardVM: BoardViewModel
    private var context: NSManagedObjectContext
    private var movesQueue: FILOQueue<Move> = FILOQueue<Move>.init()
    private var game: Game!
    
    
    init(context: NSManagedObjectContext, boardVM: BoardViewModel, players : [Player]) {
        self.context = context
        self.boardVM = boardVM
        self.players = players
    }
    public func initializeGame(firstPlayer: String, secondPlayer: String) -> Game {
        let game = Game(context: context, firstPlayer: firstPlayer, secondPlayer: secondPlayer)
        return game
        
    }
    public func makeMove(row: Int, col: Int, game: Game, _ board: inout Board) throws {
        do {
            try checkFieldAvailability(row: row, col: col)
            let newMove = Move(context: context, row: Int16(row), col: Int16(col), player: currentPlayer.name, toGame: game)
                movesQueue.enqueue(newMove)
            boardVM.setMoveOnBoard(move: newMove)
            checkQueueAndFlush(row: row, col: col)
        } catch {
            throw error
        }
           
        
    }
    
    public func saveMoveInDatabase(move: Move){
        
    }
    private func checkQueueAndFlush(row: Int, col: Int) {
        if movesQueue.size() > 6 {
            boardVM.flushField(row: row, col: col)
        }
        return
    }
    private func checkFieldAvailability(row: Int, col: Int) throws {
        guard boardVM.isMoveAvailable(row: row, col: col) else {
            throw LogicError.takenField
        }
    }
}
