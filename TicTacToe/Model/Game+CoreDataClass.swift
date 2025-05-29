//
//  Game+CoreDataClass.swift
//  TicTacToe
//
//  Created by Dominik on 28/05/2025.
//
//

import Foundation
import CoreData

@objc(Game)
public class Game: NSManagedObject {
    
    convenience init(context: NSManagedObjectContext, firstPlayer: String, secondPlayer: String, result: String = "") {
        self.init(context: context)
        self.firstPlayer = firstPlayer
        self.secondPlayer = secondPlayer
        self.result = result
    }
}
