//
//  String+FirstLetter.swift
//  US States
//
//  Created by John Hannan on 9/30/19.
//  Copyright © 2019 John Hannan. All rights reserved.
//

import Foundation


extension String {
    var firstLetter : String? {
        return self.isEmpty ? nil : String(self.first!)
    }
}
