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
            
            DownTownMap()
                .navigationBarTitleDisplayMode(.inline)
            
        }.environmentObject(locationsManager)
    }
}


struct DownTownView_Previews: PreviewProvider {
    static var previews: some View {
        DownTownView()
    }
}
