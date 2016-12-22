//
//  FlickrErrorMessageExtractor.swift
//  SimpleFlickrPhotoBrowser
//
//  Created by Stephen Stephens on 12/22/16.
//  Copyright © 2016 Stephen Stephens. All rights reserved.
//

import Foundation
import Siesta
import SwiftyJSON

/// Extract a user-visible error message if the response is JSON and has a "message" value.
struct FlickrErrorMessageExtractor: ResponseTransformer {
    func process(_ response: Response) -> Response {
        switch response {
        case .success:
            return response
        case .failure(var error):
            // Note: the .json property here is defined in Siesta+SwiftyJSON.swift
            error.userMessage = error.json["message"].string ?? error.userMessage
            return .failure(error)
        }
    }
}
