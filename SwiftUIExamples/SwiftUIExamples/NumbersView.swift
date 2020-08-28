//
//  NumbersView.swift
//  SwiftUIExamples
//
//  Created by jjh9 on 8/28/20.
//  Copyright © 2020 jjh9. All rights reserved.
//

import SwiftUI

struct NumbersView: View {
    var body: some View {
        List {
            ForEach(0..<100) {i in
                HStack {
                    Spacer()
                    Text("\(i)")
                }

            }
        }
    }
}

struct NumbersView_Previews: PreviewProvider {
    static var previews: some View {
        NumbersView()
    }
}
