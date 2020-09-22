//
//  HomeView.swift
//  US States
//
//  Created by jjh9 on 9/22/20.
//  Copyright © 2020 jjh9. All rights reserved.
//

import SwiftUI

struct HomeView: View {
    @State var usstates = USStates()
    @State var showingPreferences = false
    
    
    var body: some View {
        NavigationView {
            List {
                NavigationLink(destination: USStatesListView(usstates: $usstates)) {
                    Text("See All")
                }
            }
            .navigationBarTitle(Text("My Home"))
            .navigationBarItems(trailing: preferenceButton)
            .sheet(isPresented: $showingPreferences) {
                Preferences(usstates: self.$usstates, showingPreferences: self.$showingPreferences)
            }
        }
    }
    
    var preferenceButton: some View {
        Button(action: { self.showingPreferences.toggle() }) {
            Image(systemName: "person.crop.circle")
                .imageScale(.large)
                .accessibility(label: Text("User Profile"))
                .padding()
        }
    }
    
}

struct HomeView_Previews: PreviewProvider {
    static var previews: some View {
        HomeView()
    }
}
