//
//  UIColor+Random.swift
//  We Are
//
//  Created by jjh9 on 8/21/20.
//  Copyright © 2020 jjh9. All rights reserved.
//

import Foundation


import UIKit

extension UIColor {

    static var randomColor : UIColor {return UIColor(red: CGFloat(arc4random() % 256)/255.0, green: CGFloat(arc4random() % 256)/255.0, blue: CGFloat(arc4random() % 256)/255.0, alpha: 1.0)}
    
}
