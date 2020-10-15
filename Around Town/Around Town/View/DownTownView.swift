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
            
            ZStack {
                
                DownTownMap()
                    .navigationBarTitleDisplayMode(.inline)
                
                if locationsManager.mappedPlaces.count > 0 {
                    VStack {
                        
                        Spacer()
                        
                        PlacesView()
                            .frame(height:placesHeight)
                    }
                }
                
                if locationsManager.route != nil {
                    VStack {
                        DirectionsView(route: $locationsManager.route)
                            .frame(height:placesHeight)
                        Spacer()
                    }
                    
                }
            }
            
            
        }
        .navigationViewStyle(StackNavigationViewStyle()) 
        .environmentObject(locationsManager)
    }
    
    var placesHeight : CGFloat = 70.0
}


struct DownTownView_Previews: PreviewProvider {
    static var previews: some View {
        DownTownView()
    }
}
