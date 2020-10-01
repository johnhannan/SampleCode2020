//
//  PlacesView.swift
//  Around Town
//
//  Created by jjh9 on 10/1/20.
//

import SwiftUI

struct PlacesView: View {
    @EnvironmentObject var locationsManager : LocationsManager
    
    var body: some View {
        ScrollView(.horizontal) {
            LazyHStack {
                ForEach(locationsManager.mappedPlaces.indices, id:\.self) { index in
                    PlaceView(places: $locationsManager.mappedPlaces, index: index)                        .padding()
                }
            }
        }
    }
}

struct PlacesView_Previews: PreviewProvider {
    static var previews: some View {
        PlacesView()
    }
}
