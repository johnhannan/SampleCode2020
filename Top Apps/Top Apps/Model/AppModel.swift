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
    
   

    init() {
        //TODO: retrieve data & populate topApps array
        retrieveData()
    }
    
    func retrieveData() {
        let url = URL(string: urlString)!
        let urlSession = URLSession.shared
        
        let task = urlSession.dataTask(with: url) { (data, response, error) in
            guard error == nil else {
                print(error?.localizedDescription ?? "Error")
                return
            }
            
            if let data = data {
                DispatchQueue.main.sync {
                    self.topApps = self.appsFrom(data: data)
                }
                self.retrieveImageData()
            }
            
        }
        task.resume()
        
    }
    
    func appsFrom(data:Data) -> [AppInfo] {
        var _topApps : [AppInfo]
        let decoder = JSONDecoder()
        do {
            let apps = try decoder.decode(TopAppData.self, from: data)
            let entries = apps.feed.entry
            _topApps = entries.map {AppInfo(entry: $0)}
        } catch {
            _topApps = []
        }
        return _topApps
    }
    
    // download all the image data
    func retrieveImageData() {
        let urlSession = URLSession.shared
        for i in self.topApps.indices {
            let url = URL(string:topApps[i].imageURL)
            let task = urlSession.downloadTask(with: url!) { (imageURL, response, error) in
                guard error == nil else {print("Error"); return}
                
                if let imageURL = imageURL {
                    if let data = try? Data(contentsOf: imageURL) {
                        DispatchQueue.main.async {
                            self.topApps[i].addImage(data: data)
                        }
                        
                    }
                }
                
            }
            task.resume()
        }
    }
    
}
