//
//  Color+Custom.swift
//  US States
//
//  Created by jjh9 on 9/11/20.
//  Copyright © 2020 jjh9. All rights reserved.
//

import Foundation
import SwiftUI

extension Color {
    static let lightTan =  Color(red: 1.0, green: 234.0/255.0, blue: 184.0/255.0)
    static let mediumTan =  Color(red: 153/255.0, green: 102.0/255.0, blue: 51.0/255.0)
    static let darkTan =  Color(red: 79.0/255.0, green: 47.0/255.0, blue: 0.0/255.0)
}


extension UIColor {
    static var randomColor : UIColor {return UIColor(red: CGFloat(arc4random() % 256)/255.0, green: CGFloat(arc4random() % 256)/255.0, blue: CGFloat(arc4random() % 256)/255.0, alpha: 1.0)}
    
    static var lightBlue : UIColor {return UIColor(red: 216.0/255.0, green: 241.0/255.0, blue: 155.0/255.0, alpha: 1.0)}
    
    static var mediumBlue : UIColor {return UIColor(red: 106.0/255.0, green: 133.0/255.0, blue: 255.0/255.0, alpha: 1.0)}
    
    static var darkBlue : UIColor {return UIColor(red: 1.0/255.0, green: 46.0/255.0, blue: 255.0/255.0, alpha: 1.0)}
    
    
    static var lightTan : UIColor {return UIColor(red: 1.0, green: 234.0/255.0, blue: 184.0/255.0, alpha: 1.0)}
    
    static var mediumTan : UIColor {return UIColor(red: 153.0/255.0, green: 102.0/255.0, blue: 51.0/255.0, alpha: 1.0)}
    
    static var darkTan : UIColor {return UIColor(red: 79.0/255.0, green: 47.0/255.0, blue: 0.0/255.0, alpha: 1.0)}
}
