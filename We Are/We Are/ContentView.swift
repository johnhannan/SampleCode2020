//
//  ContentView.swift
//  We Are
//
//  Created by jjh9 on 8/28/20.
//  Copyright © 2020 jjh9. All rights reserved.
//

import SwiftUI

struct ContentView: View {
    var body: some View {
        
        ZStack {
            
            Color.orange
            
            VStack {
                LionView()
                CheeringView()
            }
            
        }.edgesIgnoringSafeArea(.all)

    }
    
}

struct CheeringView : View {
    
    var body: some View {
        VStack(spacing: 30) {
            
            
            Text("We Are")
                .frame(width: cheerWidth, height: nil, alignment: .center)
            Text("Penn State")
                .frame(width: cheerWidth, height: nil, alignment: .center)
            
            
            Button("Cheer")  {  }
                .padding(5)
                .background(Color.blue)
                .foregroundColor(.white)
                .cornerRadius(20)
                .padding()
            
        }.font(.largeTitle)
    }
    
    let cheerWidth : CGFloat = 300
}

struct LionView: View {

    var body: some View {
        VStack {
        Spacer()
        Image("Mascot0")
            .resizable()
            .aspectRatio(contentMode: ContentMode.fit)

        }
    }
}


struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
    }
}


