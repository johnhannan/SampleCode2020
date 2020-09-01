//
//  UIColor+Random.swift
//  We Are
//
//  Created by jjh9 on 8/21/20.
//  Copyright © 2020 jjh9. All rights reserved.
//

import Foundation


import UIKit
import SwiftUI

extension UIColor {

    static var randomColor : UIColor {return UIColor(red: CGFloat(arc4random() % 256)/255.0, green: CGFloat(arc4random() % 256)/255.0, blue: CGFloat(arc4random() % 256)/255.0, alpha: 1.0)}
    
}

extension Color {

    static var randomColor : Color {return Color(red: Double((Int.random(in: 0...255)))/255.0, green: Double((Int.random(in: 0...255)))/255.0, blue: Double((Int.random(in: 0...255)))/255.0 )}
    
}
