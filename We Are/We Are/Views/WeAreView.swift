//
//  ContentView.swift
//  We Are
//
//  Created by jjh9 on 8/28/20.
//  Copyright © 2020 jjh9. All rights reserved.
//

import SwiftUI

struct WeAreView: View {
    //@ObservedObject var cheerViewModel  = CheerViewModel()
    @State var cheerModel = CheerModel()
    
    
    var body: some View {
        
        ZStack {
            
            Color.orange
            
            VStack {
                Spacer(minLength: topSpacerLength)
                LionView(imageName: cheerModel.mascotImage)
                CheeringView(cheerModel: $cheerModel)
            }
            
        }.edgesIgnoringSafeArea(.all)
      

    }
    let topSpacerLength : CGFloat = 40.0
}




struct WeAreView_Previews: PreviewProvider {
    static var previews: some View {
        WeAreView(cheerModel: CheerModel())
    }
}


