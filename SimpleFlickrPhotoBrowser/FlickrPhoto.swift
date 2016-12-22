//
//  FlickrPhoto.swift
//  SimpleFlickrPhotoBrowser
//
//  Created by Stephen Stephens on 12/8/16.
//  Copyright © 2016 Stephen Stephens. All rights reserved.
//

import SwiftyJSON

struct FlickrPhoto {
    let farm: Int?
    let id: String?
    let owner: String?
    let secret: String?
    let server: String?
    let title: String?
    init (json: JSON) throws {
        
        id = json["id"].string
        owner = json["owner"].string
        secret = json["secret"].string
        server = json["server"].string
        farm = json["farm"].int
        title = json["title"].string
    }
    
    func GetBaseUrlString() -> String?{
        var baseUrlString = ""
        if let farmString = farm {
            baseUrlString = "https://c\(String(farmString)).staticflickr.com/\(String(farmString))"
        } else { return nil }
        if let serverString = server {
            baseUrlString.append("/\(serverString)")
        } else { return nil }
        if let idString = id {
            baseUrlString.append("/\(idString)")
        } else { return nil }
        if let secretString = secret {
            baseUrlString.append("_\(secretString)")
        } else { return nil }
        return baseUrlString
    }
    
    /// ---
    /// # URLs for Different Image Sizes
    /// The last 2 characters before ".jpg" in the image URL
    /// determine the size of the image the URL refers to:
    ///      Square   		_s.jpg
    ///      Large Square 	_q.jpg
    ///      Thumbnail 		_t.jpg
    ///      Small           _m.jpg
    ///      Small 320 		_n.jpg
    ///      Medium          .jpg
    ///      Medium 640      _z.jpg
    ///      Medium 800      _c.jpg
    ///      Large           _b.jpg
    ///      Original		_o.jpg
    /// ---
    
    //** Returns the URL of the small square thumbnail of the photo. */
    func GetSquareThumbnailUrlString() -> String? {
        if let baseUrlString = GetBaseUrlString() {
                return baseUrlString + "_q.jpg"
        }
        else { return nil }
    }
    
    //** Returns the URL of the medium sized photo. */
    func GetMediumPhotoUrlString() -> String? {
        if let baseUrlString = GetBaseUrlString() {
            return baseUrlString + "_c.jpg"
        }
        else { return nil }
    }
}
