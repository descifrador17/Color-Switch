//
//  User+CoreDataProperties.swift
//  Color Switch
//
//  Created by Dayal, Utkarsh on 27/04/21.
//
//

import Foundation
import CoreData


extension User {

    @nonobjc public class func fetchRequest() -> NSFetchRequest<User> {
        return NSFetchRequest<User>(entityName: "User")
    }

    @NSManaged public var id: UUID?
    @NSManaged public var password: String?
    @NSManaged public var username: String?
    @NSManaged public var scores: NSOrderedSet?

}

// MARK: Generated accessors for scores
extension User {

    @objc(insertObject:inScoresAtIndex:)
    @NSManaged public func insertIntoScores(_ value: Score, at idx: Int)

    @objc(removeObjectFromScoresAtIndex:)
    @NSManaged public func removeFromScores(at idx: Int)

    @objc(insertScores:atIndexes:)
    @NSManaged public func insertIntoScores(_ values: [Score], at indexes: NSIndexSet)

    @objc(removeScoresAtIndexes:)
    @NSManaged public func removeFromScores(at indexes: NSIndexSet)

    @objc(replaceObjectInScoresAtIndex:withObject:)
    @NSManaged public func replaceScores(at idx: Int, with value: Score)

    @objc(replaceScoresAtIndexes:withScores:)
    @NSManaged public func replaceScores(at indexes: NSIndexSet, with values: [Score])

    @objc(addScoresObject:)
    @NSManaged public func addToScores(_ value: Score)

    @objc(removeScoresObject:)
    @NSManaged public func removeFromScores(_ value: Score)

    @objc(addScores:)
    @NSManaged public func addToScores(_ values: NSOrderedSet)

    @objc(removeScores:)
    @NSManaged public func removeFromScores(_ values: NSOrderedSet)

}

extension User : Identifiable {

}
