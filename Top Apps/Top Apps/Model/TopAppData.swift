//
//  TopAppData.swift
//  Top Apps
//
//  Created by John Hannan on 11/14/19.
//  Copyright © 2019 John Hannan. All rights reserved.
//
//  Created by John Hannan on 11/9/18.
//  Copyright © 2018 John Hannan. All rights reserved.
//
//  Data parsed from JSON

import Foundation

// Structs for decoding JSON
// TopAppData is the top-level struct we decode the JSON into
struct TopAppData : Decodable {
    let feed : Feed
    
    private enum CodingKeys: String, CodingKey {
        case feed
    }
    
    struct Feed : Decodable {
        let entry : [Entry]
        private enum CodingKeys: String, CodingKey {
            case entry
        }
    }
}

// Struct representing one App from the JSON
struct Entry : Decodable {
    let title : [String:String]
    let summary : [String:String]
    let imageURLs : [ImageURL]
    
    private enum CodingKeys: String, CodingKey {
        case title
        case summary
        case imageURLs = "im:image"
    }
    
    struct ImageURL : Decodable {
        let urlString : String
        private enum CodingKeys: String, CodingKey {
            case urlString = "label"
        }
    }
}

// This is the class we use to model an individual app
struct AppInfo : Identifiable {
    let title:String
    let author:String
    let imageURL:String
    var imageData : Data?
    let summary:String
    let id = UUID()
    
    init(entry:Entry) {
        let titleAuthor = entry.title["label"] ?? " "
        let split = titleAuthor.components(separatedBy: "-")
        self.title = split[0]
        self.author = split[1]
        self.summary = entry.summary["label"] ?? " "
        imageURL = entry.imageURLs[0].urlString
        imageData = nil
    }
    
    mutating func addImageData(_ data: Data?) {
        imageData = data
    }
}

