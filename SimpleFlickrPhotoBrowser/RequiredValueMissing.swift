//
//  RequiredValueMissing.swift
//  SimpleFlickrPhotoBrowser
//
//  Created by Stephen Stephens on 12/8/16.
//  Copyright © 2016 Stephen Stephens. All rights reserved.
//

import Foundation

/// Error type for the JSON parsing extension to the optional type.
struct MissingRequiredValue: Error {
    let name: String?
    let type: Any.Type
}
