//
//  TownData.swift
//  Around Town
//
//  Created by jjh9 on 9/17/20.
//

import Foundation
import CoreLocation

struct Spot : Identifiable {
    let coordinate : CLLocationCoordinate2D
    let title : String?
    var id = UUID()
    
    init(coordinate:CLLocationCoordinate2D, title:String? = nil) {
        self.coordinate = coordinate
        self.title = title
    }
}

struct TownData {
    
    
    //MARK: - Locations
    // Centered in downtown State College
    static let initialCoordinate = CLLocationCoordinate2D(latitude: 40.794978, longitude: -77.860785)
    
    // define 4 corner points of downtown State College
    static let downtownCoordinates = [(40.791831951313,-77.865203974557),
                                      (40.800364570711,-77.853778542571),
                                      (40.799476294037,-77.8525124806654),
                                      (40.7908968034537,-77.8638607142546)].map {(a,b) in CLLocationCoordinate2D(latitude: a, longitude: b)}
    
    static let favorites : [Spot] =
        [Spot(coordinate: CLLocationCoordinate2D(latitude: 40.79550030, longitude: -77.85900170), title: "Cheese Shoppe"),
         Spot(coordinate: CLLocationCoordinate2D(latitude: +40.79414797, longitude: -77.86152899), title: "The Corner Room")]
    
    //MARK: - Search Categories
    static let categories = ["None", "Airport", "Bar", "Coffee", "Dining", "Gas Station", "Grocery", "Hospital", "Hotel", "Laundry", "Library", "Movies", "Parking", "Pizza", "Shopping"]
    
    
    static func imageNameFor(category:String) -> String {
        return category
    }
    
    
}
