//
//  Errors.swift
//  herocam-service
//
//  Created by Diomidis Papas on 11/24/16.
//
//

import Foundation

enum JsonError: Error {
    case invalid
}

enum RemoteError: Error {
    case generic
}

enum ConstructionError: Error {
    case invalid
}
