//
//  RectangleModel.swift
//  Gestures
//
//  Created by jjh9 on 11/10/20.
//

import Foundation
import CoreGraphics  // Not a good idea, but convenient for this exaple

struct Rect : Identifiable{
    var rect : CGRect
    var id = UUID()
    
    var width : CGFloat {rect.size.width}
    var height : CGFloat {rect.size.height}
    
    var center : CGPoint {
        get {return CGPoint(x: rect.midX, y: rect.midY)}
        set(newValue) {
            rect.origin = CGPoint(x: newValue.x - width/2.0,
                                  y: newValue.y - height/2.0)
        }
    }
    
    func contains(_ other:Rect) -> Bool {
        self.rect.contains(other.rect)
    }
    
    // remove a piece just by setting its size to zero
    mutating func remove() {
        rect.size = CGSize.zero
    }

}

class RectangleModel : ObservableObject{
    
    @Published var rectangles = [Rect]()
    @Published var creatingRect : Rect?
    
    
    func newRect(at point: CGPoint) {
        
    }
    
    func updateRect(to point: CGPoint) {
        
    }
    
    func addRect() {
        
    }
    
    func checkMovedRect(_ rect:Rect) {
        
    }
}
