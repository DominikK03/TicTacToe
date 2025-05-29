//
//  Game.swift
//  TicTacToe
//
//  Created by Dominik on 27/05/2025.
//

import Foundation
import CoreData

struct Board {
    var board : [[Move]]
    
    mutating func initBoard(context:  NSManagedObjectContext, game: Game){
        board = (0..<3).map{
            row in (0..<3).map {
                col in
                Move(context: context, row: Int16(row), col: Int16(col), player: "", toGame: game)
            }
            
        }
    }
}
