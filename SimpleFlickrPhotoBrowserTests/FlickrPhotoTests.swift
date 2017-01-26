//
//  FlickrPhotoTests.swift
//  SimpleFlickrPhotoBrowser
//
//  Created by Stephen Stephens on 1/18/17.
//  Copyright © 2017 Stephen Stephens. All rights reserved.
//

import XCTest

@testable import SimpleFlickrPhotoBrowser

class FlickrPhotoTests: XCTestCase {
    
    // MARK: Subject Under Test
    
    var sut: FlickrPhoto!
    
    // MARK: Test lifecycle
    
    override func setUp() {
        super.setUp()
        setupFlickrPhoto()
    }
    
    override func tearDown() {
        super.tearDown()
    }
    
    // MARK: Test setup
    
    func setupFlickrPhoto(){
        sut = FlickrPhoto(farm: 0, id: "blah", owner: "ownerPlaceholder", secret: "secretPlaceholder", server: "serverPlaceholder", title: "titlePlaceholder")
    }
    
    // MARK: Tests
    
    func testUrlFormation() {
        
        if let urlString = sut.GetBaseUrlString() {
            XCTAssert(urlString == "https://farm0.staticflickr.com//serverPlaceholder/blah_secretPlaceholder") } else {
            XCTFail()
        }
    }
}
