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
            annotationItems: locationsManager.placeItems)
            { (item:Place) in  MapAnnotation(coordinate: item.coordinate) {
            Image(item.category)
        }
            
        }
    }
}

struct DownTownMap_Previews: PreviewProvider {
    static var previews: some View {
        DownTownMap()
    }
}
