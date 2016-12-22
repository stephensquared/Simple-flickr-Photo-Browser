//
//  Optional+required.swift
//  SimpleFlickrPhotoBrowser
//
//  Created by Stephen Stephens on 12/8/16.
//  Copyright © 2016 Stephen Stephens. All rights reserved.
//

import Foundation

// Extend the Optional type such that an error is thrown if a value is not parsed from a required field. Example usage: id = try json["id"].string.required("photo.id")
extension Optional {
    func required(_ name: String = "<unknown>") throws -> Wrapped {
        guard let value = self else {
            throw MissingRequiredValue(name: name, type: Wrapped.self)
        }
        return value
    }
}
