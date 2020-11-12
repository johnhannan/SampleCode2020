//
//  RectangleModel.swift
//  Gestures
//
//  Created by jjh9 on 11/10/20.
//

import Foundation
import CoreGraphics  // Not a good idea, but convenient for this exaple

struct Rect : Identifiable {
    var rect : CGRect
    var id = UUID()
    
    // Convenience properties
    var width : CGFloat {rect.size.width}
    var height : CGFloat {rect.size.height}
    var center : CGPoint {
        get {return CGPoint(x: rect.midX, y: rect.midY)}
        set(newValue) {
            rect.origin = CGPoint(x: newValue.x - width/2.0,
                                  y: newValue.y - height/2.0)
        }
    }
    
    // use for previews
    static var anyRect = Rect(rect: CGRect(x: 100, y: 100, width: 100, height: 100))
    
    // check if other rectangle is within this rectangle
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
    @Published var inProgressRect : Rect?
    
    
    func newRect(at point: CGPoint) {
        
    }
    
    func updateRect(to point: CGPoint) {
        
    }
    
    func addRect() {
        
    }
    
    // a rectangle was moved.  do we need to do anything with it?
    func checkMovedRect(_ rect:Rect) {
        
    }
}
