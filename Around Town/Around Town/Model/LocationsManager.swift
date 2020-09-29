//
//  Location.swift
//  Around Town
//
//  Created by jjh9 on 9/28/20.
//

import Foundation
import MapKit

struct Place :Identifiable {
    var category : String
    var placemark : CLPlacemark
    var id = UUID()
    
    var coordinate : CLLocationCoordinate2D {placemark.location!.coordinate}
}

class LocationsManager : ObservableObject {
    
    @Published var region = MKCoordinateRegion(center: TownData.initialCoordinate, span: MKCoordinateSpan(latitudeDelta: 0.01, longitudeDelta: 0.01))
    
    let degrees : CLLocationDegrees = 0.01
    
    @Published var placeItems = [Place]()
    
    var selectedCategory : Int = 0 {
        didSet {
            performSearch(on: TownData.categories[selectedCategory])
        }
    }
    
    
    func performSearch(on category:String) {
        
        //make a local search request and start it
        let request = MKLocalSearch.Request()
        request.region = region
        request.naturalLanguageQuery = category
        let search = MKLocalSearch(request: request)
        
        search.start { (response, error) in
            guard error == nil else {print(error!.localizedDescription); return}
            
            let mapItems = response!.mapItems
            for item in mapItems {
                let place = Place(category: category, placemark: item.placemark)
                self.placeItems.append(place)
            }
                
            
        }
    }
    
}
