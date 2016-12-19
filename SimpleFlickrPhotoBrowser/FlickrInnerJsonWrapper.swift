//
//  FlickrInnerJsonWrapper.swift
//  SimpleFlickrPhotoBrowser
//
//  Created by Stephen Stephens on 12/12/16.
//  Copyright © 2016 Stephen Stephens. All rights reserved.
//

import Foundation
import SwiftyJSON

struct FlickrInnerJsonWrapper {
    
    let page: Int
    let pages: Int
    let perpage: Int
    let total: Int32?
    var photoArray: [FlickrPhoto]
    
    init (json: JSON) throws {
        
        // Need int32 here because sometimes values get large
        total = json["total"].int32Value
        page = json["page"].int!
        pages = json["pages"].int!
        perpage = json["perpage"].int!
        
        var totalInt16: Int
        
        if total == nil {
            totalInt16 = 0
        } else if total! >= Int32(FlickrApi.photosPerPage) {
            totalInt16 = FlickrApi.photosPerPage
        } else {
            totalInt16 = Int(total!)
        }

        photoArray = []
        if (total != 0){
            for n in 1...totalInt16 {
                photoArray.append(try FlickrPhoto(json: json["photo"][n]))
            }
        }
    }
}
