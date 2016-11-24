//
//  Landmark.swift
//  herocam-service
//
//  Created by Diomidis Papas on 11/24/16.
//
//

import Foundation
import Vapor
import Fluent

final class Landmark: Model {
    var id: Node?
    let title: String
    let wikipediaSnippet: String
    let wikipediaURLString: String
    var wikipediaThumbnailURLString: String?
    
    init(title: String, wikipediaSnippet: String, wikipediaURLString: String, wikipediaThumbnailURLString: String) {
        self.id = UUID().uuidString.makeNode()
        self.title = title
        self.wikipediaSnippet = wikipediaSnippet
        self.wikipediaURLString = wikipediaURLString
        self.wikipediaThumbnailURLString = wikipediaThumbnailURLString
    }
    
    init(node: Node, in context: Context) throws {
        id = try node.extract("id")
        title = try node.extract("title")
        wikipediaURLString = try node.extract("wikipedia_link")
        wikipediaThumbnailURLString = try node.extract("wikipedia_thumbnail")
        wikipediaSnippet = try node.extract("wikipedia_snippet")
    }
    
    func makeNode(context: Context) throws -> Node {
        return try Node(node: [
            "id": id,
            "landmark": title,
            "wikipedia_title": title,
            "wikipedia_link": wikipediaURLString,
            "wikipedia_snippet": wikipediaSnippet,
            "wikipedia_thumbnail": wikipediaThumbnailURLString
            ])
    }
}

extension Landmark: Preparation {
    static func prepare(_ database: Database) throws {
        //
    }
    
    static func revert(_ database: Database) throws {
        //
    }
}

extension Landmark {
    class func testLandmark() -> Landmark {
        return Landmark(title: "Buckingham Palace", wikipediaSnippet: "The palace chapel was destroyed by a German bomb during World War II; the Queen's Gallery was built on the site and opened to the public in 1962 to exhibit works of art from the Royal Collection.\nThe original early 19th-century interior designs, many of which survive, include widespread use of brightly coloured scagliola and blue and pink lapis, on the advice of Sir Charles Long. King Edward VII oversaw a partial redecoration in a Belle cream and gold colour scheme. Many smaller reception rooms are furnished in the Chinese regency style with furniture and fittings brought from the Royal Pavilion at Brighton and from Carlton House. The palace has 775 rooms, and the garden is the largest private garden in London. The state rooms, used for official and state entertaining, are open to the public each year for most of August and September, and on selected days in winter and spring.", wikipediaURLString: "https://en.wikipedia.org/?curid=3969", wikipediaThumbnailURLString: "https://upload.wikimedia.org/wikipedia/commons/thumb/b/b4/Buckingham_Palace%2C_London_-_April_2009.jpg/700px-Buckingham_Palace%2C_London_-_April_2009.jpg")
    }
}
