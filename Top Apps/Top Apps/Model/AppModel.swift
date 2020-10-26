//
//  AppModel.swift
//  Top Apps
//
//  Created by John Hannan on 11/14/19.
//  Copyright © 2019 John Hannan. All rights reserved.
//

import Foundation
import Combine

class AppModel : ObservableObject {
    
    @Published var topApps = [AppInfo]()
    let urlString = "https://itunes.apple.com/us/rss/toppaidapplications/limit=100/json"
    
   
    
    // We'll do this three different ways in class
    init() {

    }
    
    
}
