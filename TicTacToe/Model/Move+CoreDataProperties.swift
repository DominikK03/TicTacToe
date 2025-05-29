//
//  Move+CoreDataProperties.swift
//  TicTacToe
//
//  Created by Dominik on 28/05/2025.
//
//

import Foundation
import CoreData


extension Move {

    @nonobjc public class func fetchRequest() -> NSFetchRequest<Move> {
        return NSFetchRequest<Move>(entityName: "Move")
    }

    @NSManaged public var col: Int16
    @NSManaged public var player: String?
    @NSManaged public var row: Int16
    @NSManaged public var toGame: Game?

}

extension Move : Identifiable {

}
