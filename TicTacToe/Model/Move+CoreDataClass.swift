//
//  Move+CoreDataClass.swift
//  TicTacToe
//
//  Created by Dominik on 28/05/2025.
//
//

import Foundation
import CoreData

@objc(Move)
public class Move: NSManagedObject {
    public static let CROSS_TAG = "X"
    public static let CIRCLE_TAG = "O"
    
    convenience init(context: NSManagedObjectContext, row: Int16, col: Int16, player: String, toGame: Game?){
        self.init(context: context)
        self.col = col
        self.row = row
        self.player = player
        self.toGame = toGame
    }
}
