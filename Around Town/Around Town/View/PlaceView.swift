//
//  PlaceView.swift
//  Around Town
//
//  Created by jjh9 on 10/1/20.
//

import SwiftUI
import MapKit

struct PlaceView: View {
    @Binding  var places : [Place]
    var index : Int
    //var place : Place
    
    // Need placeholder "empty" place when view is rendered after deleting annotations
    var place : Place {index < places.count ? places[index] : Place.empty}
    
    
    var body: some View {
        HStack {
            VStack {
                Text(place.name)
                Text(place.address)
            }
            Button(action: {}, label: {Image(systemName: "info.circle")})
        }.padding()
        .foregroundColor(.white)
        .background(RoundedRectangle(cornerRadius: 15).fill(Color.red)
                       )

    }
}

//struct PlaceView_Previews: PreviewProvider {
//    static var previews: some View {
//        PlaceView(places: .constant([Place(category: "any", placemark: MKPlacemark()]), index:0)
//    }
//}
