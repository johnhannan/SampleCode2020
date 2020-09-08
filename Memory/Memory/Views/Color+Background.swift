//
//  Color+Background.swift
//  Memory
//
//  Created by jjh9 on 9/8/20.
//  Copyright © 2020 jjh9. All rights reserved.
//

import Foundation
import SwiftUI



extension Color {
    static func background(for state: GameState) -> Color {
        switch state {
            case .notPlaying:
                return ViewConstants.notPlayingBackgroundColor
            case .memorizing:
                return ViewConstants.memorizingBackgroundColor
            case .guessing:
                return ViewConstants.guessingBackgroundColor
            case .lost:
                return ViewConstants.lostBackgroundColor
            case .won:
                return ViewConstants.wonBackgroundColor
            }
    }
}
