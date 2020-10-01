//
//  DownTownView.swift
//  Around Town
//
//  Created by jjh9 on 9/28/20.
//

import SwiftUI

struct DownTownView: View {
    @ObservedObject var locationsManager = LocationsManager()
    
    var body: some View {
        NavigationView {
            
            VStack {
                
            DownTownMap()
                .navigationBarTitleDisplayMode(.inline)
                
            PlacesView()
                .frame(height:placesHeight)
                
            }
            
        }.environmentObject(locationsManager)
    }
    
    var placesHeight : CGFloat = 60.0
}


struct DownTownView_Previews: PreviewProvider {
    static var previews: some View {
        DownTownView()
    }
}
