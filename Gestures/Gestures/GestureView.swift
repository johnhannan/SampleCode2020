//
//  GestureView.swift
//  Gestures
//
//  Created by jjh9 on 11/9/20.
//

import SwiftUI

struct GestureView: View {
    @State private var tapCount = 0
    @State private var pressCount = 0
    @State private var doubleCount = 0
    
    var body: some View {
        return VStack(spacing:30) {
            Text("Double: \(doubleCount)")
            
            Text("Taps: \(tapCount)")
            
            Text("Presses: \(pressCount)")
            
            Image("Penn Seal")
                .resizable()
                .aspectRatio(contentMode: .fit)
            
            RoundedRectangle(cornerRadius: 10)
                .foregroundColor(.orange)
                .frame(width: 100, height: 100)
            
            Text("Bottom Text")
        }
        .font(.largeTitle)
    }
}

struct GestureView_Previews: PreviewProvider {
    static var previews: some View {
        GestureView()
    }
}
