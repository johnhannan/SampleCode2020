//
//  RectangleModel.swift
//  Gestures
//
//  Created by jjh9 on 11/10/20.
//

import Foundation
import CoreGraphics  // Not a good idea, but convenient for this exaple

extension CGPoint {
    func offsetBy(_ size:CGSize) -> CGPoint {
        return CGPoint(x: x + (size.width), y: y + (size.height))
    }
    
    func distanceFrom(_ a: CGPoint) -> CGFloat {
        let xDist = a.x - self.x
        let yDist = a.y - self.y
        return CGFloat(sqrt(xDist.sqr + yDist.sqr))
    }
}

extension CGFloat {
    var sqr : CGFloat {self * self}
}



struct Rect : Identifiable {
    var rect : CGRect
    var id = UUID()
    var colorRGB : (Double, Double, Double)
    
    var width : CGFloat {abs(rect.size.width)}
    var height : CGFloat {abs(rect.size.height)}
    
    var center : CGPoint { CGPoint(x: rect.midX, y: rect.midY)}

    
    // use for previews
    static var anyRect = Rect(rect: CGRect(x: 100, y: 100, width: 100, height: 100), colorRGB: (1.0,0.0,1.0))
    
    // check if other rectangle is within this rectangle
    func contains(_ other:Rect) -> Bool {
        return false
    }
    
    // remove a piece just by setting its size to zero
    mutating func remove() {
      
    }
    
    private func fourCorners() -> [CGPoint] {
        let ulCorner = self.rect.origin
        let urCorner = self.rect.origin.offsetBy(CGSize(width: self.rect.width, height: 0))
        let lrCorner = self.rect.origin.offsetBy(CGSize(width: self.rect.width, height: self.rect.height))
        let llCorner = self.rect.origin.offsetBy(CGSize(width: 0, height: self.rect.height))
        return [ulCorner, urCorner, lrCorner, llCorner]
    }

}

class RectangleModel : ObservableObject{
    
    @Published var rectangles = [Rect]()
    @Published var inProgressRect : Rect?
    
    // gesture started (tap)
    func newRect(at point: CGPoint) {
        let colorRGB = (Double.random(in: 0...1), Double.random(in: 0...1), Double.random(in: 0...1))
        inProgressRect = Rect(rect: CGRect(origin: point, size: CGSize.zero), colorRGB: colorRGB)
    }
    
    func updateRect(to point: CGPoint) {
        if let origin = inProgressRect?.rect.origin {
            let width = point.x - origin.x
            let height = point.y - origin.y
            inProgressRect!.rect.size = CGSize(width: width, height: height)
        }
    }
    
    func addRect() {
        if var rect = inProgressRect {
            rect.rect = rect.rect.standardized
            rectangles.append(rect)
            inProgressRect = nil
        }
    }
    
    // a rectangle was moved.  do we need to do anything with it?
    func checkMovedRect(_ rect:Rect) {
        
    }
}
