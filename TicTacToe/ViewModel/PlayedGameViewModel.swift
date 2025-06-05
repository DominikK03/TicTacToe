import Foundation
import CoreData
import SwiftUI

class PlayedGameViewModel: ObservableObject {
    var moves: [Move] = []
    let context: NSManagedObjectContext
    private var game: Game
    
    init(game: Game, context: NSManagedObjectContext) {
        self.game = game
        self.context = context
        fetchMoves()
    }
    
    func fetchMoves() {
        let request: NSFetchRequest<Move> = Move.fetchRequest()
        request.predicate = NSPredicate(format: "toGame == %@", game)
        request.sortDescriptors = [NSSortDescriptor(key: "timestamp", ascending: true)]
        do {
            moves = try context.fetch(request)
            moves.removeFirst(9)
        } catch {
            print("Failed to fetch moves: \(error)")
            moves = []
        }
    }
    
    func boardAtMove(_ moveIndex: Int) -> [[String]] {
        var board = Array(repeating: Array(repeating: "", count: 3), count: 3)
        for (_, move) in moves.prefix(moveIndex).enumerated() {
            let row = Int(move.row)
            let col = Int(move.col)
            board[row][col] = move.player ?? ""
        }
        return board
    }
} 
