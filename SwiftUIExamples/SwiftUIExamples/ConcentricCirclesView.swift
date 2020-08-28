//
//  ConcentricCirclesView.swift
//  Background
//
//  Created by jjh9 on 8/28/20.
//  Copyright © 2020 jjh9. All rights reserved.
//

import SwiftUI

struct ConcentricCirclesView: View {
    var body: some View {
        
        ZStack {
            ForEach(0..<10) {i in
                Circle()  //.border(Color.orange)
                    .fill(i%2 == 0 ? Color.pink : Color.green)
                    .scaleEffect(CGFloat(1.0 - CGFloat(i)*0.05))
                    
                    
            }
        }
    }
}

struct ConcentricCirclesView_Previews: PreviewProvider {
    static var previews: some View {
        ConcentricCirclesView()
    }
}
