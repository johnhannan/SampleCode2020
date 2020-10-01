//
//  PlaceView.swift
//  Around Town
//
//  Created by jjh9 on 10/1/20.
//

import SwiftUI

struct PlaceView: View {
    @Binding  var places : [Place]
    var index : Int
    //var place : Place
    
    var place : Place {places[index]}
    
    var body: some View {
        HStack {
            VStack {
                Text(place.name)
                Text(place.address)
            }
            Button(action: {}, label: {Image(systemName: "info.circle")})
        }.onAppear() {
            places[index].highlightToggle()
        }
        .onDisappear() {
            places[index].highlightToggle()
        }
    }
}

//struct PlaceView_Previews: PreviewProvider {
//    static var previews: some View {
//        PlaceView()
//    }
//}
