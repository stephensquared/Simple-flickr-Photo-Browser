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
    var total: Int
    var photoArray: [FlickrPhoto]
    init (json: JSON) throws {
        if let pageValue = json["page"].int {
            page = pageValue
        } else {
            page = 0
        }
        if let pagesValue = json["pages"].int {
            pages = pagesValue
        } else {
            pages = 0
        }
        if let perpageValue = json["perpage"].int {
            perpage = perpageValue
        } else {
            perpage = 0
        }
        
        /* The interesting photo API returns the total as an int value, while the photo search API returns the total value in quotes (as a String). */
        if let totalValue = json["total"].int {
            total = totalValue
        } else if let totalAsString = json["total"].string {
            if let totalAsInt = Int(totalAsString) {
                total = totalAsInt
            } else {
                total = 0
            }
        } else {
            total = 0
        }
        
        if total > FlickrApi.photosPerPage {
            total = FlickrApi.photosPerPage
        }
        photoArray = []
        if total > 0 {
            for n in 0...total {

                photoArray.append(try FlickrPhoto(json: json["photo"][n]))
                print("n = \(n) and photoArray[n].title = \(photoArray[n].title)")
            }
        }
    }
}
