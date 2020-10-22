//
//  PlayerMO+CoreDataProperties.swift
//  Footballers
//
//  Created by jjh9 on 10/22/20.
//
//

import Foundation
import CoreData


extension PlayerMO {

    @nonobjc public class func fetchRequest() -> NSFetchRequest<PlayerMO> {
        return NSFetchRequest<PlayerMO>(entityName: "PlayerMO")
    }

    @NSManaged public var firstname: String
    @NSManaged public var lastname: String
    @NSManaged public var country: String
    @NSManaged public var info: String
    @NSManaged public var teamname: String
    @NSManaged public var team: TeamMO

}

extension PlayerMO : Identifiable {
    var fullname : String {firstname + " " + lastname}
}
