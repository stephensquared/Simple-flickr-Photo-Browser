//
//  PhotoGalleryItemCollectionViewCellTests.swift
//  SimpleFlickrPhotoBrowser
//
//  Created by Stephen Stephens on 1/25/17.
//  Copyright © 2017 Stephen Stephens. All rights reserved.
//

import XCTest
import Siesta

@testable import SimpleFlickrPhotoBrowser

class PhotoGalleryItemCollectionViewCellTests: XCTestCase {
    
    // MARK: Subject Under Test
    
    var sut: PhotoGalleryItemCollectionViewCell!
    
    // MARK: Test lifecycle
    
    override func setUp() {
        super.setUp()
        setupTest()
    }
    
    override func tearDown() {
        super.tearDown()
    }
    
    // MARK: Test setup
    
    func setupTest(){
        sut = PhotoGalleryItemCollectionViewCell()
    }
    
    // MARK: Tests
    
    func testGalleryInitialization() {
        XCTAssertNotNil(sut)
    }
}
