//
//  Score+CoreDataProperties.swift
//  Color Switch
//
//  Created by Dayal, Utkarsh on 27/04/21.
//
//

import Foundation
import CoreData


extension Score {

    @nonobjc public class func fetchRequest() -> NSFetchRequest<Score> {
        return NSFetchRequest<Score>(entityName: "Score")
    }

    @NSManaged public var id: UUID?
    @NSManaged public var score: Int64
    @NSManaged public var user: User?

}

extension Score : Identifiable {

}
