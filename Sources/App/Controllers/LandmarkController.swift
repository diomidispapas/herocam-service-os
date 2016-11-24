//
//  LandmarkController.swift
//  herocam-service
//
//  Created by Diomidis Papas on 11/24/16.
//
//

import Vapor
import HTTP

final class LandmarkController: ResourceRepresentable {
    
    // MARK: ResourceRepresentable
    func makeResource() -> Resource<Landmark> {
        return Resource(
            store: create
        )
    }
    
    // MARK: Private
    private func create(request: Request) throws -> ResponseRepresentable {
        let parameters = try retrieveParameters(for: request)
        guard let photo = parameters.file else {
            return Response(status: .badRequest, headers: [:], body: Body())
        }
        
        do {
            let landmark = try GoogleVision().tag(file: photo)
            return landmark
        } catch _ {
            return Response(status: .other(statusCode: 404, reasonPhrase: "image could not recognized"), headers: [:], body: Body())
        }
    }
}

extension LandmarkController {
    func retrieveParameters(for request: Request) throws -> Multipart {
        guard let image = request.multipart?["photo"] else { throw Abort.custom(status: .badRequest, message:"image could not be parsed") }
        return image
    }
}
