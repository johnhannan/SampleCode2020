//
//  ContentView.swift
//  We Are
//
//  Created by jjh9 on 8/28/20.
//  Copyright © 2020 jjh9. All rights reserved.
//

import SwiftUI

struct WeAreView: View {
    var body: some View {
        
        ZStack {
            
            Color.orange
            
            VStack {
                Spacer()
                LionView()
                CheeringView()
            }
            
        }.edgesIgnoringSafeArea(.all)

    }
    
}




struct WeAreView_Previews: PreviewProvider {
    static var previews: some View {
        WeAreView()
    }
}


