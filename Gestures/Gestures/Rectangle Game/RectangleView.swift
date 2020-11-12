//
//  RectangleView.swift
//  Gestures
//
//  Created by jjh9 on 11/12/20.
//

import SwiftUI

struct RectangleView: View {
    @EnvironmentObject var rectangleModel : RectangleModel
    @State private var offset = CGSize.zero
    var body: some View {
        
        let tapGesture = LongPressGesture(minimumDuration: 0.1)
            .onEnded{ (value) in
                
            }
        let dragGesture = DragGesture()
            .onChanged{ (value) in
                offset = value.translation
            }
            .onEnded { (value) in
                offset = CGSize.zero

            }
        let tapDrag = SimultaneousGesture(tapGesture,dragGesture)
        
        
        Rectangle()
            .foregroundColor(Color.red)  // worry about individual colors later
            //.frame(width: <#T##CGFloat?#>, height: <#T##CGFloat?#>)  // depends on model object
            //.position(<#T##position: CGPoint##CGPoint#>)   // depends on model object
            .offset(offset)  // result of dragging
            .gesture(tapDrag)
    }
}

struct RectangleView_Previews: PreviewProvider {
    static var previews: some View {
        RectangleView()
    }
}
