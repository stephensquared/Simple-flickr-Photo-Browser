//
//  PhotoGalleryItem.swift
//  SimpleFlickrPhotoBrowser
//
//  Created by Stephen Stephens on 12/12/16.
//  Copyright © 2016 Stephen Stephens. All rights reserved.
//

import Foundation

class PhotoGalleryItem {
    var itemImageUrlString: String
    init(_ imageUrlString: String) {
        itemImageUrlString = imageUrlString
    }
    class func newPhotoGalleryItem(_ urlString: String) -> PhotoGalleryItem {
        return PhotoGalleryItem(urlString)
    }
}
