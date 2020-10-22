//
//  TeamMO+CoreDataProperties.swift
//  Footballers
//
//  Created by jjh9 on 10/22/20.
//
//

import Foundation
import CoreData


extension TeamMO {

    @nonobjc public class func fetchRequest() -> NSFetchRequest<TeamMO> {
        return NSFetchRequest<TeamMO>(entityName: "TeamMO")
    }

    @NSManaged public var name: String
    @NSManaged public var roster: Set<PlayerMO>

}

// MARK: Generated accessors for roster
extension TeamMO {

    @objc(addRosterObject:)
    @NSManaged public func addToRoster(_ value: PlayerMO)

    @objc(removeRosterObject:)
    @NSManaged public func removeFromRoster(_ value: PlayerMO)

    @objc(addRoster:)
    @NSManaged public func addToRoster(_ values: NSSet)

    @objc(removeRoster:)
    @NSManaged public func removeFromRoster(_ values: NSSet)

}

extension TeamMO : Identifiable {

}
