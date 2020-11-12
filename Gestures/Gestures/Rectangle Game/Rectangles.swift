//
//  Rectangles.swift
//  Gestures
//
//  Created by jjh9 on 11/12/20.
//

import SwiftUI

struct Rectangles: View {
    @StateObject var rectangleModel = RectangleModel()
    
    var body: some View {
        ZStack {
            
        }
        .environmentObject(rectangleModel)
    }
}

struct Rectangles_Previews: PreviewProvider {
    static var previews: some View {
        Rectangles()
    }
}
