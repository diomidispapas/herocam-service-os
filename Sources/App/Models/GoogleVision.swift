//
//  GoogleVision.swift
//  herocam-service
//
//  Created by Diomidis Papas on 11/24/16.
//
//

import Foundation
import Vapor
import HTTP
import Fluent

struct GoogleVision: TagProvider {
    
    // MARK: TagProvider
    func tag(file: Multipart.File) throws -> Landmark {
        let jsonRequest = [
            "requests": [
                "image": [
                    "content": file.data.base64String
                ],
                "features": [
                    [
                        "type": "LANDMARK_DETECTION",
                        "maxResults": 10
                    ]
                ]
            ]
        ]
        
        let jsonData = try JSONSerialization.data(withJSONObject: jsonRequest, options: .prettyPrinted)
        let body = Body.data(try jsonData.makeBytes())
        
        guard let apiKey = drop.config["keys", "keys", "google-vision"]?.string, let response = try? drop.client.post("https://vision.googleapis.com/v1/images:annotate?key=\(apiKey)", headers: [:], query: [:], body: body) else {
            print("!Error on image recognition service")
            throw RemoteError.generic
        }
        
        guard let json = response.json else {
            throw JsonError.invalid
        }
        
        guard let searchKeywork = json["responses"]?["landmarkAnnotations"]?["description"]?.node.array?.first?.array?.first?.string  else {
            print("!Error while parsing the tagging result")
            throw ConstructionError.invalid
        }
        
        do {
            let wikipediaResponse = try Wikipedia.search(for: searchKeywork)
            return Landmark(title: wikipediaResponse.title, wikipediaSnippet: wikipediaResponse.body, wikipediaURLString: wikipediaResponse.wikipediaLink, wikipediaThumbnailURLString: wikipediaResponse.thumbnailLink)
            
        } catch _ {
            print("!Error making the wikipedia request")
            throw ConstructionError.invalid
        }
    }
}

