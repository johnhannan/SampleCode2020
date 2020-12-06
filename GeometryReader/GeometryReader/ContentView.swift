//
//  ContentView.swift
//  GeometryReader
//
//  Created by Goki on 12/3/20.
//

import SwiftUI

struct ContentView: View {
    
    var body: some View {
        GeometryReader { fullGeometry in
            ScrollView(.horizontal, showsIndicators: false) {
                HStack(spacing: 20) {
                    ForEach(0..<15) { index in
                        GeometryReader { cardGeometry in
                            ZStack {
                                Color.blue
                                
                                VStack {
                                    Spacer()
                                    
                                    Image(systemName: "car")
                                        .resizable()
                                        .scaledToFit()
                                        .padding()
                                    
                                    HStack {
                                        Text("Card \(index)")
                                            .bold()
                                        Spacer()
                                    }
                                }
                                .foregroundColor(.white)
                                .padding()
                            }
                            .cornerRadius(10)
                            .rotation3DEffect(
                                .degrees( -Double(cardGeometry.frame(in: .global).midX - fullGeometry.frame(in: .global).midX)/20 ),
                                axis: (x: 0, y: 1, z: 0)
                            )
                            .opacity( 1 - abs(Double(cardGeometry.frame(in: .global).midX - fullGeometry.frame(in: .global).midX)/Double((fullGeometry.frame(in: .global).width/2))) )
                        }
                        .frame(width: 150, height: 200)
                    }
                }
                .padding(.leading, 5)
                .padding(.vertical, 50)
            }
            
        }
    }
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
    }
}
