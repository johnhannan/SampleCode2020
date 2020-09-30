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
    @State var annotationIndex = 0
    
    var body: some View {
        
        Map(coordinateRegion: $locationsManager.region,
            interactionModes: .all,
            showsUserLocation: true,
            userTrackingMode: $userTrackingMode,
            annotationItems: locationsManager.mappedPlaces,
            annotationContent: annotationsForCategory)
            
            .toolbar {
                ToolbarItem(placement: .navigationBarTrailing) {
                    searchPicker
                }
                ToolbarItem(placement: .navigationBarLeading) {
                    clearButton
                }
            }
    }
    
    var searchPicker : some View {
        Picker(selection: $locationsManager.searchCategory, label: Image(systemName: "magnifyingglass")) {
            ForEach(TownData.categories.indices, id:\.self) { index in
                Text(TownData.categories[index])
            }
        }.pickerStyle(MenuPickerStyle())
    }
    
    var clearButton : some View {Button(action: {}) {
        Image(systemName: "xmark.circle")}
    }
    
    var annotationChooser : some View {Button(action:{
        annotationIndex = (annotationIndex + 1) % 3
    }) {
        Image(systemName: "mappin.circle")}
    }
    

    
    func annotationsForCategory (item:Place) -> some MapAnnotationProtocol {
        MapAnnotation(coordinate: item.coordinate) {
            Image(item.category)
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
