//
//  Preferences.swift
//  Memory
//
//  Created by jjh9 on 9/10/20.
//  Copyright © 2020 jjh9. All rights reserved.
//

import SwiftUI

struct Preferences: View {
    @Binding var isShowingPreferences : Bool
    @ObservedObject var model : GameModel
    @Binding var selectedIndex : Int
    var themes : Themes
    
    var body: some View {
        NavigationView {
            Form {
                Section(header: Text("Length of Sequence")) {
                    Stepper(value: $model.sequenceLength, in: 3...10) {
                        Text("\(model.sequenceLength)")
                    }
                }
                
                Section(header: Text("Choose Theme")) {
                    Picker("Theme", selection: $selectedIndex) {
                        ForEach(themes.indices, id: \.self) { (index) in
                            (self.themes[index][0]).fixedSize().frame(width:15, height:15, alignment:.center)
                        }
                    }
                }
                
                Section() {
                    HStack {
                        Spacer()
                        Button("Dismiss") { self.isShowingPreferences.toggle() }
                        Spacer()
                    }
                }.navigationBarTitle("Preferences")
                
            }
        }
        
    }
}



//struct Preferences_Previews: PreviewProvider {
//    static var previews: some View {
//        Preferences()
//    }
//}
