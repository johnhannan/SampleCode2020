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
        //retrieveData()
        //retrieveDataWithBlocks()
        retrieveDataWithCombine()
    }
    enum URLError : Error {
        case unknown
    }
    
    var allCancellable : Cancellable?
    
    func retrieveDataWithCombine() {
        let url = URL(string: urlString)!
        let urlSession = URLSession.shared
        
        allCancellable = urlSession.dataTaskPublisher(for: url)
            .tryMap { data, response -> Data in
                guard let httpResponse = response as? HTTPURLResponse,
                      200..<300 ~= httpResponse.statusCode else {
                    throw URLError.unknown
                }
                return data
            }
            
            .decode(type: TopAppData.self, decoder: JSONDecoder())
            .map {$0.feed.entry}
            .replaceError(with: [])
            
            .sink{ (entries) in
                let apps = entries.map {AppInfo(entry:$0)}
                DispatchQueue.main.sync {
                    self.topApps = apps
                }
                self.topApps.indices.forEach {self.retrieveImageData(at: $0)}
            }
        
    }
    
    var cancellables = Set<AnyCancellable>()
    
    func retrieveImageData(at index:Int) {
        let url = URL(string: topApps[index].imageURL)!
        let session = URLSession.shared
        
        // Use Combine
        session.dataTaskPublisher(for: url)
            .map { $0.data }
            .replaceError(with: Data())
            .eraseToAnyPublisher()
            .receive(on: RunLoop.main)
            
            .sink { (data) in
                DispatchQueue.main.async{
                    self.topApps[index].addImage(data: data)
                }
            }
            .store(in: &cancellables) // we retain the subscriber

    }
    
    func retrieveDataWithBlocks() {
        let url = URL(string: urlString)
        let queue = OperationQueue()
        
        
        let block = BlockOperation {
            let data = try? Data(contentsOf: url!)
            
            if let data = data {
                DispatchQueue.main.sync {
                    self.topApps = self.appsFrom(data: data)
                }
            } else {
                // handle error
            }
        }
        
        
        queue.addOperation(block)
        
        let imageQueue = DispatchQueue(label: "TopApps ImageQueue", attributes: .concurrent)
        
        let imageOperation = BlockOperation {
            for i in self.topApps.indices {
                imageQueue.async {
                    let url = URL(string: self.topApps[i].imageURL)
                    let data = try? Data(contentsOf: url!)
                    DispatchQueue.main.sync {
                        self.topApps[i].addImage(data: data)
                    }
                }
            }
        }
        
        imageOperation.addDependency(block)
        queue.addOperation(imageOperation)
        
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
                
                if let imageURL = imageURL,
                   let data = try? Data(contentsOf: imageURL) {
                    DispatchQueue.main.async {
                        self.topApps[i].addImage(data: data)
                        
                    }
                }
            }
            task.resume()
        }
    }
    
}
