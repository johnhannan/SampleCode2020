//
//  CheeringView.swift
//  We Are
//
//  Created by jjh9 on 9/1/20.
//  Copyright © 2020 jjh9. All rights reserved.
//

import SwiftUI

struct CheeringView: View {
    @EnvironmentObject var cheerViewModel : CheerViewModel
    
    var body: some View {
        VStack(spacing: 20) {
            
            
            Text(cheerViewModel.firstCheer)
                .frame(width: cheerWidth, height: nil, alignment: .center)
                .opacity(cheerViewModel.shouldShowFirstCheer ? 1.0 : 0.0)
            
            
            Text(cheerViewModel.secondCheer)
                .frame(width: cheerWidth, height: nil, alignment: .center)
                .opacity(cheerViewModel.shouldShowSecondCheer ? 1.0 : 0.0)
            
            Button("Cheer")  { self.cheerViewModel.doACheer() }
                
                .padding(5)
                .background(Color.blue)
                .foregroundColor(.white)
                .cornerRadius(20)
                .padding()
            
        }.font(.largeTitle)
    }
    
    let cheerWidth : CGFloat = 300
}

 
struct CheeringView_Previews: PreviewProvider {
    static var previews: some View {
        CheeringView().environmentObject(CheerViewModel())
    }
}
