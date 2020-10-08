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

class LocationsManager :  NSObject, ObservableObject, CLLocationManagerDelegate {
    
    let locationManager : CLLocationManager
    var showsUserLocation = true
    
    override init() {
       let restaurantsManager = RestaurantsManager()
        restaurants = restaurantsManager.restaurants
        
        locationManager = CLLocationManager()
        
        super.init()
        
        locationManager.delegate = self
        locationManager.desiredAccuracy = kCLLocationAccuracyBest
        
    }
    
    
    //MARK: - Published values
    @Published var region = MKCoordinateRegion(center: TownData.initialCoordinate, span: MKCoordinateSpan(latitudeDelta: TownData.span, longitudeDelta: TownData.span))
    
    // Map will annotate these items
    @Published var mappedPlaces = [Place]()
    
    @Published var route : MKRoute?
    
    //MARK: - CLLocationManager Delegate
    func locationManagerDidChangeAuthorization(_ manager: CLLocationManager) {
        switch manager.authorizationStatus {
        case .notDetermined:
            locationManager.requestWhenInUseAuthorization()
        case .authorizedAlways, .authorizedWhenInUse:
            locationManager.startUpdatingLocation()
            showsUserLocation = true
        default:
            locationManager.stopUpdatingLocation()
            showsUserLocation = false
        }
    }
    
    func locationManager(_ manager: CLLocationManager, didUpdateLocations locations: [CLLocation]) {
        let newCoordinates = locations.map {$0.coordinate}
        if let coordinate = newCoordinates.first {
            region.center = coordinate
        }
    }
    
    func locationManager(_ manager: CLLocationManager, didFailWithError error: Error) {
         
    }
    
    
    
    //MARK: - Geocoding Restaurants
    // List of restaurant names & addresses read in from JSON file
    let restaurants : [Restaurant]
    
    // when user selects a restaurant we annotate map with it
    var selectedRestaurant : Int = 0 {
        didSet {
            geocode(for: restaurants[selectedRestaurant])
        }
    }
    

    func geocode(for restaurant:Restaurant) {
        let geocoder = CLGeocoder()
        geocoder.geocodeAddressString(restaurant.address) { (placemarks, error) in
            guard (error == nil) else {return}
            
            if let placemark = placemarks?.first {
                let mapMark = MKPlacemark(placemark: placemark)
                let place = Place(category: "Dining", placemark: mapMark)
                self.mappedPlaces.removeAll()
                self.mappedPlaces = [place]
                self.region.center = mapMark.coordinate
                
            }
            
        }
    }

    //MARK: - Directions
    
    func provideDirections(to place:Place) {
        let request = MKDirections.Request()
        request.source = MKMapItem.forCurrentLocation()
        request.destination = MKMapItem(placemark: place.placemark)
        request.transportType = .walking
        request.requestsAlternateRoutes = true
        let directions = MKDirections(request: request)
        directions.calculate { (response, error) in
            guard (error == nil) else {print(error!.localizedDescription); return}
            
            if let route = response?.routes.first {
                self.route = route
            }
        }
    }
    
    
    
    //MARK: - Local Search
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
