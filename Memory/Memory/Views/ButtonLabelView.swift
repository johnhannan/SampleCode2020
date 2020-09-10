//
//  ButtonLabelView.swift
//  Memory
//
//  Created by jjh9 on 9/10/20.
//  Copyright © 2020 jjh9. All rights reserved.
//
// Label for the Guess Buttons
// Initialize with either a color of a label (string of one character)
// Used as the view for the Guess Buttons

import SwiftUI

struct ButtonLabelView : View {
    var label : String = ""
    var color : Color = .clear
    var body: some View {
        ZStack {
            RoundedRectangle(cornerRadius: 10)
                .fill(color)
                .aspectRatio(1.0, contentMode: .fit)
                .shadow(radius: 20)
            Text(label)
        }
    }
}
