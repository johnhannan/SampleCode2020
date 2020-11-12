//
//  Dragger.swift
//  Shapes
//
//  Created by jjh9 on 11/9/20.
//  Copyright © 2020 jjh9. All rights reserved.
//
import SwiftUI

struct Dragger<Content> : View where Content: View{
    @Binding var position: CGPoint
    @Binding var pieces : [Piece]
    var index : Int
    var content: () -> Content
    @GestureState private var dragOffset = CGSize.zero
    @State private var offset = CGSize.zero
    
    var body: some View {
        let tapGesture = LongPressGesture(minimumDuration: 0.1)
            .onEnded{ (value) in
                //pieces.bringToFront(index: index)
            }
        let dragGesture = DragGesture()
            .onChanged{ (value) in
                offset = value.translation
            }
            .onEnded { (value) in
                self.position = self.position.offsetBy(offset)
                offset = CGSize.zero
            }
        let tapDrag = SimultaneousGesture(tapGesture,dragGesture)

        return  content()
            .position(position)
            .offset(x: offset.width, y: offset.height)
            .gesture(tapDrag)
    }
}

//extension Array where Element == Piece {
//    mutating func bringToFront(index:Int) {
//        for i in 0..<self.count {
//            self[i].zIndex = (i == index) ? 1 : 0
//        }
//    }
//}

extension CGPoint {
    func offsetBy(_ size:CGSize) -> CGPoint {
        return CGPoint(x: x + size.width, y: y + size.height)
    }
}
