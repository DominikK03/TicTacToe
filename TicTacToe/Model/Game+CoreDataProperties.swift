//
//  Game+CoreDataProperties.swift
//  TicTacToe
//
//  Created by Dominik on 28/05/2025.
//
//

import Foundation
import CoreData


extension Game {

    @nonobjc public class func fetchRequest() -> NSFetchRequest<Game> {
        return NSFetchRequest<Game>(entityName: "Game")
    }

    @NSManaged public var secondPlayer: String?
    @NSManaged public var firstPlayer: String?
    @NSManaged public var result: String?

}

extension Game : Identifiable {

}
