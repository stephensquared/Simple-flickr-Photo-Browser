//
//  DataModelTests.swift
//  SimpleFlickrPhotoBrowser
//
//  Created by Stephen Stephens on 1/18/17.
//  Copyright © 2017 Stephen Stephens. All rights reserved.
//

import Foundation
import XCTest
import Siesta
import SwiftyJSON

@testable import SimpleFlickrPhotoBrowser

class DataModelTests: XCTestCase {
    
    override func setUp() {
        super.setUp()
    }
    
    override func tearDown() {
        super.tearDown()
    }
    
    func testFlickrPhotoUrlFormation() {
        let testPhoto = FlickrPhoto(farm: 0, id: "blah", owner: "ownerPlaceholder", secret: "secretPlaceholder", server: "serverPlaceholder", title: "titlePlaceholder")
        if let urlString = testPhoto.GetBaseUrlString() {
            XCTAssert(urlString == "https://farm0.staticflickr.com//serverPlaceholder/blah_secretPlaceholder") } else {
            XCTFail()
        }
    }
    
    func testPhotoGalleryItemInit() {
        let galleryItem = PhotoGalleryItem("testing")
        assert(galleryItem.itemImageUrlString.characters.count > 0)
    }
    
    func testPhotoGalleryItemCollectionViewCellInit() {
        let testPhotoGalleryItem = PhotoGalleryItemCollectionViewCell()
        let bundlePath = Bundle.main.path(forResource: "PlaceHolderImage", ofType: "jpg")
        let placeHolderImage = UIImage(contentsOfFile: bundlePath!)
        testPhotoGalleryItem.photoImageView = RemoteImageView(image: placeHolderImage)
    }
}
