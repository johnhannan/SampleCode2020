//
//  PreferenceButtonViewe.swift
//  Memory
//
//  Created by jjh9 on 9/10/20.
//  Copyright © 2020 jjh9. All rights reserved.
//

import SwiftUI

struct PreferenceButtonView : View {
    @EnvironmentObject var gameModel : GameModel
    @State private  var isShowingPreference = false
    var themes : Themes
    @Binding var selectedThemeIndex : Int
    
    var body: some View {
   
        Button(action: { self.isShowingPreference.toggle() }) {
            Image(systemName: "gear")
                .resizable()
                .aspectRatio(contentMode: .fit)
                .frame(width: 25, height: 25, alignment: .center)
                .foregroundColor(.black)
                .padding(10)
        }.sheet(isPresented: $isShowingPreference) {
            Preferences(isShowingPreferences: self.$isShowingPreference, model: self.gameModel, selectedIndex: self.$selectedThemeIndex, themes:self.themes)
            
        }
        
    }
}

//struct PreferenceButtonViewe_Previews: PreviewProvider {
//    @State static var length : Int = 10
//    static var previews: some View {
//        PreferenceButtonView().environmentObject(MemoryViewModel(with: 4))
//    }
//}
