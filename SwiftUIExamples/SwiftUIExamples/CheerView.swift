//
//  ContentView.swift
//  SwiftUIExamples
//
//  Created by jjh9 on 8/25/20.
//  Copyright © 2020 jjh9. All rights reserved.
//

import SwiftUI

struct CheerView: View {
    var body: some View {
        HStack {
            Image("Mascot0")
            VStack {
                Text("We Are!")
                Text("Penn State")
            }
            VStack {
                Group {
                Text("Thank You")
                Text("You're Welcome")
                }
            }
        }
    }
}


struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        CheerView()
    }
}
