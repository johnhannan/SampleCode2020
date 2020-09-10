//
//  Themes.swift
//  Memory
//
//  Created by jjh9 on 9/10/20.
//  Copyright © 2020 jjh9. All rights reserved.
//
// Themes encapsulates array of buttonlabelviews we can use in our game



import SwiftUI

struct Themes {
    static let colors : [ButtonLabelView]  = [Color.red, .blue, .green, .yellow].map {ButtonLabelView(color: $0)}
    static let numbers  = ["1", "2", "3", "4"].map {ButtonLabelView(label: $0) }
    static let chess  = ["♚", "♛", "♜", "♞"].map {ButtonLabelView(label: $0) }
    static let sports  = ["🏀", "⚾️", "🏈", "⚽️"].map {ButtonLabelView(label: $0) }
    static let suits  = ["♠︎", "♣︎", "♥︎", "♦︎"].map {ButtonLabelView(label: $0) }
    static let flowers = ["🌼", "🌹", "🌻", "🌸"].map {ButtonLabelView(label: $0) }
    let themes = [Self.colors, numbers, chess, sports, suits, flowers]
    
    //TODO: make this subscriptable and with indices (like an array)
}
