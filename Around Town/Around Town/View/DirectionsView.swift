//
//  DirectionsView.swift
//  Around Town
//
//  Created by jjh9 on 10/8/20.
//

import SwiftUI
import MapKit

struct DirectionsView: View {
    @Binding var route : MKRoute?
    
    var body: some View {
        TabView {
            ForEach(route?.steps ?? [], id:\.instructions) {step in
                Text(step.instructions)
            }
        }.tabViewStyle(PageTabViewStyle(indexDisplayMode: .never))
        .background(Color.lightBlue)
        .onDisappear() {
            route = nil
        }
    }
}

//struct DirectionsView_Previews: PreviewProvider {
//    static var previews: some View {
//        DirectionsView()
//    }
//}
