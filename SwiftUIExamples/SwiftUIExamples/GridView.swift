//
//  GridView.swift
//  SwiftUIExamples
//
//  Created by jjh9 on 8/28/20.
//  Copyright © 2020 jjh9. All rights reserved.
//

import SwiftUI

struct GridView : View {

    let columns = 4
    let rows = 5
    
    var body: some View {
        
        ScrollView {
        VStack {
            ForEach(0..<rows) {r in
                HStack {
                    ForEach(0..<self.columns) { c in
                        
                        Color(UIColor.randomColor)
                            .aspectRatio(1.0, contentMode: .fit)
                        .cornerRadius(15)
                    }
                }
            }.padding()
        }
    }
    }
}

struct GridView_Previews: PreviewProvider {
    static var previews: some View {
        GridView()
    }
}
