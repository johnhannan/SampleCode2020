//
//  RectangleModel.swift
//  Gestures
//
//  Created by jjh9 on 11/10/20.
//

import Foundation
import CoreGraphics  // Not a good idea

struct Piece : Identifiable{
    var rect : CGRect
    var id = UUID()
}

class RectangleModel {
    
    @Published var pieces = [Piece]()
    @Published var currentPiece : Piece?
    
}
