import Foundation
import CoreData

class GameHistoryViewModel: ObservableObject {
    @Published var games: [Game] = []
    let context: NSManagedObjectContext
    
    init(context: NSManagedObjectContext) {
        self.context = context
        fetchGames()
    }
    
    func fetchGames() {
        let request: NSFetchRequest<Game> = Game.fetchRequest()
        request.sortDescriptors = [NSSortDescriptor(key: "firstPlayer", ascending: true)]
        request.predicate = NSPredicate(format: "result != %@ AND result != nil", "")
        do {
            games = try context.fetch(request)
        } catch {
            print("Failed to fetch games: \(error)")
            games = []
        }
    }
    
    func refresh() {
        fetchGames()
    }
    
    func deleteGames(at offsets: IndexSet) {
        for index in offsets {
            let game = games[index]
            let moveRequest: NSFetchRequest<Move> = Move.fetchRequest()
            moveRequest.predicate = NSPredicate(format: "toGame == %@", game)
            if let moves = try? context.fetch(moveRequest) {
                for move in moves {
                    context.delete(move)
                }
            }
            context.delete(game)
        }
        do {
            try context.save()
            fetchGames()
        } catch {
            print("Failed to delete game: \(error)")
        }
    }

    func deleteAllGames() {
        let request: NSFetchRequest<NSFetchRequestResult> = Game.fetchRequest()
        let deleteRequest = NSBatchDeleteRequest(fetchRequest: request)
        
        do {
            try context.execute(deleteRequest)
            try context.save()
            fetchGames()
        } catch {
            print("Failed to delete all games: \(error)")
        }
    }
} 
