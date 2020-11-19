//
//  RectangleModel.swift
//  Gestures
//
//  Created by jjh9 on 11/10/20.
//

import Foundation
import CoreGraphics  // Not a good idea, but convenient for this exaple

// CaseIterable for the Picker view
enum GameShapeNames : String, CaseIterable, Identifiable {
    case rectangle, circle
    var id: String { self.rawValue }
}

struct GameShape : Identifiable, Equatable {
    let gameShape : GameShapeNames
    var rect : CGRect
    var id = UUID()
    var colorRGB : (Double, Double, Double)
    var zIndex : Double = 0.0
    
    var width : CGFloat {abs(rect.size.width)}
    var height : CGFloat {abs(rect.size.height)}
    var center : CGPoint {
        get {return rect.center}
        set(newValue) {
            rect.center = newValue
        }
    }
    
    var radius : CGFloat = 0.0 {
        didSet {
            let width = radius * 2.0  // and height
            let origin = CGPoint(x: center.x - radius, y: center.y - radius)
            rect.origin = origin
            rect.size = CGSize(width: width, height: width)
        }
    }
    
    var area : CGFloat {
        switch gameShape {
        case .rectangle:
            return width * height
        case .circle:
            return CGFloat.pi * radius.sqr
        }
    }
    


    // Equatable
    static func ==(lhs: GameShape, rhs:GameShape) -> Bool {
        return lhs.id == rhs.id
    }
    
    // use for previews
    static var anyRect = GameShape(gameShape: .rectangle, rect: CGRect(x: 100, y: 100, width: 100, height: 100), colorRGB: (1.0,0.0,1.0))
    
    // check if other shape is within this one
    func contains(_ other:GameShape) -> Bool  {
        switch self.gameShape {
        case .rectangle:
            return self.rect.contains(other.rect)  // other can be rectangle or circle
        case .circle:
            switch other.gameShape {
            case .circle: // two circles
                return self.radius > (self.center.distanceFrom(other.center) + other.radius)
            case .rectangle:                       // all four corners less than self.radius from self.center
                return other.fourCorners().allSatisfy {self.center.distanceFrom($0) < self.radius}
            }
        }
    }
    
    private func fourCorners() -> [CGPoint] {
        let ulCorner = self.rect.origin
        let urCorner = self.rect.origin.offsetBy(CGSize(width: self.width, height: 0))
        let lrCorner = self.rect.origin.offsetBy(CGSize(width: self.width, height: self.height))
        let llCorner = self.rect.origin.offsetBy(CGSize(width: 0, height: self.height))
        return [ulCorner, urCorner, lrCorner, llCorner]
    }
    
    // increase area of piece by area of other piece
    mutating func consumes(_ other:GameShape) {

        let sizeRatio = width/height
        let newArea = width*height + other.area
        let newWidth = sqrt(newArea * sizeRatio)
        let newHeight = newArea/newWidth

        let currentCenter = self.center
        self.rect.size = CGSize(width: newWidth, height: newHeight)
        self.center = currentCenter // to trigger setting new origin
 
    }

}

class RectangleModel : ObservableObject{
    
    @Published var rectangles = [GameShape]()
    @Published var inProgressRect : GameShape?
    @Published var gameShape : GameShapeNames = .rectangle  //shapes we are creating (picker updates this)
    
    var currentZIndex : Double = 0.0
    
    
    //MARK: Creating a new Piece
    
    // gesture started (tap), a new piece is in progress
    func newRect(at point: CGPoint) {
        let colorRGB = (Double.random(in: 0...1), Double.random(in: 0...1), Double.random(in: 0...1))
        inProgressRect = GameShape(gameShape: self.gameShape, rect: CGRect(origin: point, size: CGSize.zero), colorRGB: colorRGB, zIndex: currentZIndex)
    }
    
    // gesture dragged to change size of piece
    func updateRect(to point: CGPoint) {
        switch gameShape {
        case .rectangle:
            if let origin = inProgressRect?.rect.origin {
                let width = point.x - origin.x
                let height = point.y - origin.y
                inProgressRect?.rect.size = CGSize(width:width, height:height)
                //inProgressRect?.rect = (inProgressRect?.rect.standardized)!
            }
        case .circle:
            if let circle = inProgressRect {
                inProgressRect?.radius = point.distanceFrom(circle.center)
            }
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
    
    func removeAll() {
        rectangles.removeAll()
    }
}
