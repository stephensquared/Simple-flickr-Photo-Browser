//
//  RequiredValueMissing.swift
//  SimpleFlickrPhotoBrowser
//
//  Created by Stephen Stephens on 12/8/16.
//  Copyright © 2016 Stephen Stephens. All rights reserved.
//

import Foundation

struct MissingRequiredValue: Error {
    let name: String?
    let type: Any.Type
}
