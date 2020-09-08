//
//  CheeringView.swift
//  We Are
//
//  Created by jjh9 on 9/1/20.
//  Copyright © 2020 jjh9. All rights reserved.
//

import SwiftUI

struct CheeringView: View {

    @Binding var cheerModel : CheerModel
    
    var body: some View {
        VStack(spacing: 20) {
            
            
            Text(cheerModel.weAreText)
                .frame(width: cheerWidth, height: nil, alignment: .center)
                .opacity(shouldShowFirstCheer ? 1.0 : 0.0)
            
            
            Text(cheerModel.pennStateText)
                .frame(width: cheerWidth, height: nil, alignment: .center)
                .opacity(shouldShowSecondCheer ? 1.0 : 0.0)
            
            Button("Cheer")  { self.cheerModel.incrementCheerCount() }
                
                .padding(5)
                .background(Color.blue)
                .foregroundColor(.white)
                .cornerRadius(20)
                .padding()
            
        }.font(.largeTitle)
    }
    
    let cheerWidth : CGFloat = 300
    
    var shouldShowFirstCheer : Bool {cheerModel.gameState == .weare}
    var shouldShowSecondCheer : Bool {cheerModel.gameState == .pennstate}
}

 
struct CheeringView_Previews: PreviewProvider {
    @State static var cheerModel = CheerModel()
    static var previews: some View {
        CheeringView(cheerModel: $cheerModel)
        
    }
}
