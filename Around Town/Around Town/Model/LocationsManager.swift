//
//  Location.swift
//  Around Town
//
//  Created by jjh9 on 9/28/20.
//

import Foundation
import MapKit

struct Restaurant : Codable {
    var name : String
    var address : String
}


struct Place :Identifiable {
    var category : String
    var placemark : MKPlacemark
    var id = UUID()
    var phoneNumber : String = ""
    var url : String = ""
    var highlighted : Bool = false
    
    var name : String {category == "empty" ? "" : placemark.name ?? "No Name"}
    var streetNumber : String {placemark.subThoroughfare ?? ""}
    var streetName : String {placemark.thoroughfare ?? ""}
    var address : String {streetNumber + streetName}
    
    var coordinate : CLLocationCoordinate2D {placemark.location!.coordinate}
    
    init(mapItem:MKMapItem, category:String) {
        self.category = category
        self.placemark = mapItem.placemark
        self.phoneNumber = mapItem.phoneNumber ?? ""
        self.url = mapItem.url?.description ?? ""
    }
    
    init(category:String, placemark:MKPlacemark) {
        self.category = category
        self.placemark = placemark
    }
    
    mutating func highlightToggle() {
        highlighted.toggle()
    }
    
    static let empty = Place(mapItem: MKMapItem(), category: "empty")
}

class LocationsManager : ObservableObject {
    
    init() {
        let restaurantURL = Bundle.main.url(forResource: "Restaurants", withExtension: "json")!
        do {
            let data = try Data(contentsOf: restaurantURL)
            let decoder = JSONDecoder()
            restaurants = try decoder.decode([Restaurant].self, from: data)
        } catch   {
            print("Error decoding Restaurants: \(error)")
            restaurants = []
        }
    }
    
    //MARK: Published values
    @Published var region = MKCoordinateRegion(center: TownData.initialCoordinate, span: MKCoordinateSpan(latitudeDelta: TownData.span, longitudeDelta: TownData.span))
    
    // Map will annotate these items
    @Published var mappedPlaces = [Place]()
    
    
    //MARK: Geocoding Restaurants
    // List of restaurant names & addresses read in from JSON file
    let restaurants : [Restaurant]
    
    // when user selects a restaurant we annotate map with it
    var selectedRestaurant : Int = 0
    
    
    
    
    //MARK: Local Search
    var searchCategoryIndex : Int = 0 {
        didSet {performSearch(on: TownData.categories[searchCategoryIndex])}
    }
    
    func clearSearch() {
        mappedPlaces.removeAll()
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
                self.mappedPlaces.append(place)
            }
        }
    }
}
