//
//  RectangleModel.swift
//  Gestures
//
//  Created by jjh9 on 11/10/20.
//

import Foundation
import CoreGraphics  // Not a good idea, but convenient for this exaple

enum GameShapeName {
    case rectangle
    case circle
}

struct GameShape : Identifiable, Equatable {
    var rect : CGRect
    var id = UUID()
    var colorRGB : (Double, Double, Double)
    var zIndex : Double = 0.0
    
    var width : CGFloat {abs(rect.size.width)}
    var height : CGFloat {abs(rect.size.height)}
    var area : CGFloat {width * height}
    
    var center : CGPoint {
        get {return rect.center}
        set(newValue) {
            rect.center = newValue
        }
    }

    // Equatable
    static func ==(lhs: GameShape, rhs:GameShape) -> Bool {
        return lhs.id == rhs.id
    }
    
    // use for previews
    static var anyRect = GameShape(rect: CGRect(x: 100, y: 100, width: 100, height: 100), colorRGB: (1.0,0.0,1.0))
    
    // check if other rectangle is within this rectangle
    func contains(_ other:GameShape) -> Bool {
        return  rect.contains(other.rect)
    }
    
    mutating func consumes(_ piece:GameShape) {
        let sizeRatio = width/height
        let newArea = self.area + piece.area
        let newWidth = sqrt(newArea * sizeRatio)
        let newHeight = newArea/newWidth
        let currentCenter = self.center
        self.rect.size = CGSize(width: newWidth, height: newHeight)
        self.center = currentCenter
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
    
    @Published var rectangles = [GameShape]()
    @Published var inProgressRect : GameShape?
    
    var currentZIndex : Double = 0.0
    
    
    //MARK: Creating a new Piece
    
    // gesture started (tap), a new piece is in progress
    func newRect(at point: CGPoint) {
        let colorRGB = (Double.random(in: 0...1), Double.random(in: 0...1), Double.random(in: 0...1))
        inProgressRect = GameShape(rect: CGRect(origin: point, size: CGSize.zero), colorRGB: colorRGB)
    }
    
    // gesture dragged to change size of piece
    func updateRect(to point: CGPoint) {
        if let origin = inProgressRect?.rect.origin {
            let width = point.x - origin.x
            let height = point.y - origin.y
            inProgressRect!.rect.size = CGSize(width: width, height: height)
        }
    }
    
    // gesture ended so we have created a new piece
    func addRect() {
        if var rect = inProgressRect {
            rect.rect = rect.rect.standardized
            rectangles.append(rect)
            inProgressRect = nil
        }
    }
    
    
    
    //MARK: Moving a piece
    
    func bringToFront(_ piece: GameShape) {
        if let index = rectangles.firstIndex(of: piece) {
            currentZIndex = currentZIndex + 1.0
            rectangles[index].zIndex = currentZIndex
        }
    }
    
    // The model is responsible for updating a piece's position
    func move(_ piece:GameShape, by offset:CGSize) {
        if let index = rectangles.firstIndex(of: piece) {
            rectangles[index].center = rectangles[index].center.offsetBy(offset)
            checkMovedRect(rectangles[index])
        }
    }
    
    // a rectangle was moved.  do we need to do anything with it?
    func checkMovedRect(_ piece:GameShape) {
        if let largerPieceIndex = rectangles.firstIndex(where: {$0.contains(piece) && $0 != piece }) {
            rectangles[largerPieceIndex].consumes(piece)
            if let index = rectangles.firstIndex(of: piece) {
                rectangles.remove(at: index)
            }
        }
    }
}
