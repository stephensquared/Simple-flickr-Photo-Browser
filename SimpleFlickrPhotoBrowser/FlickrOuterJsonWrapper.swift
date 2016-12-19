//
//  FlickrOuterJsonWrapper .swift
//  SimpleFlickrPhotoBrowser
//
//  Created by Stephen Stephens on 12/12/16.
//  Copyright © 2016 Stephen Stephens. All rights reserved.
//

import Foundation
import SwiftyJSON

struct FlickrOuterJsonWrapper {
    
    let stat: String?
    let photos: FlickrInnerJsonWrapper?
    
    init (json: JSON) throws {
        
        stat = json["stat"].string
        
        // TODO: Do not try to parse if the status is fail.
        
        if stat == "ok"{
            photos = try FlickrInnerJsonWrapper(json: json["photos"])
        } else {
            photos = nil
        }
    }
}
