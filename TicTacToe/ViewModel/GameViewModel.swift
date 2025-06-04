import Foundation
import CoreData

class GameViewModel: ObservableObject {
    @Published var players: [Player]
    @Published var currentPlayer: Player
    @Published var board: Board
    @Published var gameOver: Bool = false
    @Published var winner: String = ""
    private var context: NSManagedObjectContext
    private var movesQueues: [String: FILOQueue<Move>] = [:] // player name -> queue
    private var game: Game
    
    init(context: NSManagedObjectContext, players: [Player], board: Board, game: Game) {
        self.context = context
        self.players = players
        self.board = board
        self.game = game
        self.currentPlayer = players[0]
        for player in players {
            movesQueues[player.name] = FILOQueue<Move>()
        }
    }
    
    func handleTap(row: Int, col: Int) {
        guard !gameOver else { return }
        guard isMoveAvailable(row: row, col: col) else { return }
        let move = Move(context: context, row: Int16(row), col: Int16(col), player: currentPlayer.chosenSymbol.rawValue, toGame: game)
        if var queue = movesQueues[currentPlayer.name] {
            queue.enqueue(move)
            if queue.size() > 3 {
                if let oldestMove = queue.dequeue() {
                    flushField(row: Int(oldestMove.row), col: Int(oldestMove.col))
                }
            }
            movesQueues[currentPlayer.name] = queue
        }
        setMoveOnBoard(move: move)
        saveMoveInDatabase(move: move)
        checkWinner()
        if !gameOver {
            switchPlayer()
        }
    }
    
    func resetGame() {
        board.initBoard(context: context, game: game)
        currentPlayer = players[0]
        gameOver = false
        winner = ""
        for player in players {
            movesQueues[player.name] = FILOQueue<Move>()
        }
    }
    
    private func switchPlayer() {
        if currentPlayer.name == players[0].name {
            currentPlayer = players[1]
        } else {
            currentPlayer = players[0]
        }
    }
    
    private func checkWinner() {
        let winningPatterns: [[(Int, Int)]] = [
            [(0,0),(0,1),(0,2)], [(1,0),(1,1),(1,2)], [(2,0),(2,1),(2,2)], // Rows
            [(0,0),(1,0),(2,0)], [(0,1),(1,1),(2,1)], [(0,2),(1,2),(2,2)], // Columns
            [(0,0),(1,1),(2,2)], [(0,2),(1,1),(2,0)] // Diagonals
        ]
        for pattern in winningPatterns {
            let symbols = pattern.map { board.board[$0.0][$0.1].player ?? "" }
            if symbols[0] != "" && symbols.allSatisfy({ $0 == symbols[0] }) {
                winner = symbols[0]
                gameOver = true
                // Save result in Core Data
                if let winningPlayer = players.first(where: { $0.chosenSymbol.rawValue == winner }) {
                    game.result = "Player \(winningPlayer.name) wins"
                    do { try context.save() } catch { print("Failed to save game result: \(error)") }
                }
                return
            }
        }
        if board.board.flatMap({ $0 }).allSatisfy({ ($0.player ?? "") != "" }) {
            gameOver = true
            winner = "Remis"
            game.result = "Remis"
            do { try context.save() } catch { print("Failed to save game result: \(error)") }
        }
    }
    
    func saveMoveInDatabase(move: Move) {
        do {
            try context.save()
        } catch {
            print("Failed to save move: \(error)")
        }
    }
    
    func setMoveOnBoard(move: Move) {
        self.board.board[Int(move.row)][Int(move.col)] = move
    }
    
    func isMoveAvailable(row: Int, col: Int) -> Bool {
        return board.board[row][col].player == ""
    }
    
    func flushField(row: Int, col: Int) {
        let emptyField = Move(context: context, row: Int16(row), col: Int16(col), player: "", toGame: game)
        board.board[row][col] = emptyField
    }
}
