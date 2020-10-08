//
//  PlaceView.swift
//  Around Town
//
//  Created by jjh9 on 10/1/20.
//

import SwiftUI
import MapKit

struct PlaceView: View {
    @EnvironmentObject var location : LocationsManager
    @Binding  var places : [Place]
    var index : Int
    
    @State var showingActionSheet = false
    
    // Need placeholder "empty" place when view is rendered after deleting annotations
    var place : Place {index < places.count ? places[index] : Place.empty}
    
    
    var body: some View {
        HStack {
            VStack {
                Text(place.name)
                Text(place.address)
            }
            Button(action: {showingActionSheet.toggle()}, label: {Image(systemName: "info.circle")})
        }.padding()
        .foregroundColor(.white)
        .background(RoundedRectangle(cornerRadius: 15).fill(Color.red))
        .actionSheet(isPresented: $showingActionSheet) {
            ActionSheet(title: Text(place.name), message: Text(place.address), buttons: actionButtons)
        }
    }
    
    
    var actionButtons : [Alert.Button] {
        if place.phoneNumber.isEmpty && place.url.isEmpty {
            return [directionsButton, .cancel()]
        } else {
            return [directionsButton, phoneButton, urlButton, .cancel()]}
    }
    
    var directionsButton : Alert.Button {.default(Text("Directions")) {
        location.provideDirections(to: place)}}
    
    var phoneButton : Alert.Button {.default(Text(place.phoneNumber)) {
        if let url = URL(string: "tel://" + place.phoneNumber) { UIApplication.shared.open(url) }
        else {} }}
    
    var urlButton : Alert.Button {.default(Text(place.url)) {
        if let url = URL(string: place.url) {
            UIApplication.shared.open(url)
        } else {} }}
}

//struct PlaceView_Previews: PreviewProvider {
//    static var previews: some View {
//        PlaceView(places: .constant([Place(category: "any", placemark: MKPlacemark()]), index:0)
//    }
//}
