//
//  DownTownMap.swift
//  Around Town
//
//  Created by jjh9 on 9/28/20.
//

import SwiftUI
import MapKit

struct DownTownMap: View {
    @EnvironmentObject var locationsManager : LocationsManager
    @State var userTrackingMode  : MapUserTrackingMode = .follow
    
    
    var body: some View {
        

            Map(coordinateRegion: $locationsManager.region,
                interactionModes: .all,
                showsUserLocation: true,
                userTrackingMode: $userTrackingMode,
                annotationItems: locationsManager.mappedPlaces,
                annotationContent: annotationsForCategory)
                .toolbar {
                    ToolbarItem(placement: .navigationBarTrailing) {
                        diningButton
                    }
                    ToolbarItem(placement: .navigationBarTrailing) {
                        searchPicker
                    }
                    ToolbarItem(placement: .navigationBarLeading) {
                        clearButton
                    }
                }
        }
       

    var diningButton : some View {
        Picker(selection: $locationsManager.selectedRestaurant, label:Image(systemName: "map")) {
            ForEach(locationsManager.restaurants.indices, id:\.self) {index in
                Text(locationsManager.restaurants[index].name)
            }
        }.pickerStyle(MenuPickerStyle())
    }
    
    var searchPicker : some View {
        Picker(selection: $locationsManager.searchCategoryIndex, label: Image(systemName: "magnifyingglass")) {
            ForEach(TownData.categories.indices, id:\.self) { index in
                Text(TownData.categories[index])
            }
        }.pickerStyle(MenuPickerStyle())
    }
    
    var clearButton : some View {Button(action: {locationsManager.clearSearch()}) {
        Image(systemName: "xmark.circle")}
    }
    

    

    //MARK: Three different functions for creating annotations
    func annotationsForCategory (item:Place) -> some MapAnnotationProtocol {
        MapAnnotation(coordinate: item.coordinate) {
            Image(item.category).renderingMode(.template)
                .foregroundColor(item.highlighted ? Color.red : Color.black)
        }
    }
    func annotationPins (item:Place) -> some MapAnnotationProtocol {
        MapPin(coordinate: item.coordinate)
    }
    func annotationMarkers (item:Place) -> some MapAnnotationProtocol {
        MapMarker(coordinate: item.coordinate)
    }
    
 
    
    
}


struct DownTownMap_Previews: PreviewProvider {
    static var previews: some View {
        DownTownMap()
    }
}
