//
//  TagProvider.swift
//  herocam-service
//
//  Created by Diomidis Papas on 11/24/16.
//
//

import Vapor

protocol TagProvider {
    func tag(file: Multipart.File) throws -> Landmark
}
