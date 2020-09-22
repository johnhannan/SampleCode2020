//
//  Preferences.swift
//  US States
//
//  Created by jjh9 on 9/17/20.
//  Copyright © 2020 jjh9. All rights reserved.
//

import SwiftUI

struct Preferences: View {
    @Binding var usstates : USStates
    @Binding var showingPreferences : Bool
    
    var body: some View {
        NavigationView {
            Form {
                
                Text("Preferences")
                
                Section() {
                    HStack {
                        Spacer()
                        Button("Dismiss") {self.showingPreferences.toggle()}
                        Spacer()
                    }
                }
                
            }
            .navigationBarTitle("Preferences")
        }
    }
}

struct Preferences_Previews: PreviewProvider {
    @State static var usstates = USStates()
    @State static var showing = false
    static var previews: some View {
        Preferences(usstates: $usstates, showingPreferences: $showing)
    }
}
