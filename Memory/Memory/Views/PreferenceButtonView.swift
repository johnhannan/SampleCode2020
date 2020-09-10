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

    
    var body: some View {
   
        Button(action: { /*TODO: Add button action */ }) {
            Image(systemName: "gear")
                .resizable()
                .aspectRatio(contentMode: .fit)
                .frame(width: 25, height: 25, alignment: .center)
                .foregroundColor(.black)
                .padding(10)

            
        } //TODO: Make Preferences View appear
    }
}

//struct PreferenceButtonViewe_Previews: PreviewProvider {
//    @State static var length : Int = 10
//    static var previews: some View {
//        PreferenceButtonView().environmentObject(MemoryViewModel(with: 4))
//    }
//}
