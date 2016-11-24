//
//  Wikipedia.swift
//  herocam-service
//
//  Created by Diomidis Papas on 11/24/16.
//
//

import Vapor
import HTTP
import Fluent

struct WikipediaResponse: JSONInitializable {
    let title: String
    let body: String
    let wikipediaLink: String
    let thumbnailLink: String
    
    init(json: JSON) throws {
        guard let embeddedJson = json.object?.allItems.last?.1.object?.allItems.first?.1.object?.allItems.first?.1.object?.allItems  else {
            throw ConstructionError.invalid
        }
        let titleTuple = embeddedJson.filter { $0.0.string == "title" }
        let bodyTuple = embeddedJson.filter { $0.0.string == "extract" }
        let thumbnailLinkEmbeddedJSON = embeddedJson.filter { $0.0.string == "thumbnail" }
        let thumbnailSourceLinkEmbeddedJSON = thumbnailLinkEmbeddedJSON.first?.1.object?.filter { $0.0.string == "source" }
        
        title = titleTuple.first?.1.string ?? ""
        body = bodyTuple.first?.1.string ?? ""
        thumbnailLink = thumbnailSourceLinkEmbeddedJSON?.first?.1.string ?? ""
        let pageIdTuple = embeddedJson.filter { $0.0.string == "pageid" }
        if  let parsedWikipediaPageId = pageIdTuple.first?.1.int {
            wikipediaLink = "https://en.wikipedia.org/?curid=\(parsedWikipediaPageId)"
        } else {
            wikipediaLink = ""
        }
    }
}

struct Wikipedia {
    
    static func search(for keyword: String) throws -> WikipediaResponse  {
        guard let response = try? drop.client.get("https://en.wikipedia.org/w/api.php", headers: [:], query: ["action" : "query", "titles" : keyword, "format" : "json", "prop" : "extracts|pageimages", "exintro": "", "explaintext": ""], body: Body()) else {
            throw RemoteError.generic
        }
        
        guard let json = response.json else {
            throw JsonError.invalid
        }
        
        do {
            return try WikipediaResponse(json: json)
        } catch _ {
            throw ConstructionError.invalid
        }
    }
}
