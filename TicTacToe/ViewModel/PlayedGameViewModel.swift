import Foundation
import CoreData
import SwiftUI

class PlayedGameViewModel: ObservableObject {
    @Published var moves: [Move] = []
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
        request.sortDescriptors = [NSSortDescriptor(key: "objectID", ascending: true)]
        do {
            moves = try context.fetch(request)
        } catch {
            print("Failed to fetch moves: \(error)")
            moves = []
        }
    }
    
    func boardAtMove(_ moveIndex: Int) -> [[String]] {
        var board = Array(repeating: Array(repeating: "", count: 3), count: 3)
        for (i, move) in moves.prefix(moveIndex).enumerated() {
            let row = Int(move.row)
            let col = Int(move.col)
            board[row][col] = move.player ?? ""
        }
        return board
    }
} 