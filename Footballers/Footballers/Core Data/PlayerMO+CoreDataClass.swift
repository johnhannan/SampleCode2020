//
//  PlayerMO+CoreDataClass.swift
//  Footballers
//
//  Created by jjh9 on 10/22/20.
//
//

import Foundation
import CoreData

@objc(PlayerMO)
public class PlayerMO: NSManagedObject {

    static var standard : PlayerMO {
        let player = PlayerMO(context: PersistenceController.preview.container.viewContext)
        player.firstname = "Alexi"
        player.lastname = "Lalas"
        player.country = "United States"
        player.info = "This is the info"
        return player
    } 
}
