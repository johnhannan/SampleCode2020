//
//  PlacesView.swift
//  Around Town
//
//  Created by jjh9 on 10/1/20.
//

import SwiftUI

struct PlacesView: View {
    @EnvironmentObject var locationsManager : LocationsManager
    @State private var tabIndex = 0
    var body: some View {
     
            
        TabView(selection: $tabIndex) {
                ForEach(locationsManager.mappedPlaces.indices, id:\.self) { index in
                    PlaceView(places: $locationsManager.mappedPlaces, index: index)
                        .tag(index)
                        .padding()
                        .tabItem { Text("location")}
                }
            }
        .tabViewStyle(PageTabViewStyle(indexDisplayMode: .never)) 
        .onChange(of: tabIndex) { [tabIndex] (newIndex) in
            locationsManager.mappedPlaces[newIndex].highlightToggle()
            locationsManager.mappedPlaces[tabIndex].highlightToggle()
        }
        .onAppear() {
            if locationsManager.mappedPlaces.count > 0 {
            locationsManager.mappedPlaces[0].highlightToggle()
            }
        }
        
    }
}

struct PlacesView_Previews: PreviewProvider {
    static var previews: some View {
        PlacesView()
    }
}
