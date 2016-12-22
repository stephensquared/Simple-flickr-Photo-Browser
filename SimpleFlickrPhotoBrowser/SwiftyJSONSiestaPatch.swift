//
//  SiftyJSONSiestaPatch.swift
//  SimpleFlickrPhotoBrowser
//
//  Created by Stephen Stephens on 12/8/16.
//  Copyright © 2016 Stephen Stephens. All rights reserved.
//

import SwiftyJSON
import Siesta

/// Wraps JSON responses with SwiftyJSON in the reponse pipeline.
let SwiftyJSONTransformer = ResponseContentTransformer(transformErrors: true) { JSON($0.content as AnyObject) }

// Provides a .json accessor to get raw JSON from resources.
extension TypedContentAccessors {
    var json: JSON {
        return typedContent(ifNone: JSON.null)
    }
}
