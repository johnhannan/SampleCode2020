//
//  DownTownView.swift
//  Around Town
//
//  Created by jjh9 on 9/28/20.
//

import SwiftUI

struct DownTownView: View {
    @ObservedObject var locationsManager = LocationsManager()
    //@State private var selectedCategory = 0
    
    var body: some View {
        NavigationView {
            
            
            DownTownMap()
                
                .navigationBarTitleDisplayMode(.inline)
                .toolbar {
                    ToolbarItem(placement: .navigationBarTrailing) {
                        searchButton
                    }
                    ToolbarItem(placement: .navigationBarLeading) {
                        clearButton
                    }
                }
        }.environmentObject(locationsManager)
    }
    
    var searchButton : some View {
        Picker(selection: $locationsManager.selectedCategory, label: Image(systemName: "magnifyingglass")) {
            ForEach(TownData.categories.indices, id:\.self) { index in
                Text(TownData.categories[index])
            }
        }.pickerStyle(MenuPickerStyle())
    }
    
    var clearButton : some View {Button(action: {}) {
        Image(systemName: "xmark.circle")}
    }
}


struct DownTownView_Previews: PreviewProvider {
    static var previews: some View {
        DownTownView()
    }
}
