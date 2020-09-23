//
//  Preferences.swift
//  US States
//
//  Created by jjh9 on 9/17/20.
//  Copyright © 2020 jjh9. All rights reserved.
//

import SwiftUI

struct Preferences: View {
    var usstates : USStates
    @Binding var showingPreferences : Bool
    @Binding var sectionStyle: SectionStyle
    
    var body: some View {
        NavigationView {
            Form {
                
                
                Section(header: Text("List Sections")) {
                    Picker("Sections", selection: $sectionStyle) {
                        ForEach(SectionStyle.allCases, id: \.self) { sec in
                            Text(sec.rawValue)
                        }
                    }
                    .labelsHidden()
                    .pickerStyle(SegmentedPickerStyle())
                }
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
    static var usstates = USStates()
    @State static var showing = false
    @State static var sectionStyle : SectionStyle = .none
    static var previews: some View {
        Preferences(usstates: usstates, showingPreferences: $showing, sectionStyle: $sectionStyle)
    }
}
