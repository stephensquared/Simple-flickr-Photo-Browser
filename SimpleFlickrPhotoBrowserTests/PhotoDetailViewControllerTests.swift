//
//  PhotoDetailViewControllerTests.swift
//  SimpleFlickrPhotoBrowser
//
//  Created by Stephen Stephens on 1/25/17.
//  Copyright © 2017 Stephen Stephens. All rights reserved.
//
//  This file is based on a Clean Swift Xcode Template from http://clean-swift.com
//

@testable import SimpleFlickrPhotoBrowser
import XCTest

class PhotoDetailViewControllerTests: XCTestCase
{
    // MARK: Subject Under Test
    
    var sut: PhotoDetailViewController!
    var window: UIWindow!
    
    // MARK: Test lifecycle
    
    override func setUp()
    {
        super.setUp()
        window = UIWindow()
        setupViewController()
    }
    
    override func tearDown()
    {
        window = nil
        super.tearDown()
    }
    
    // MARK: Test setup
    
    func setupViewController()
    {
        let storyboard = UIStoryboard(name: "Main", bundle: Bundle.main)
        sut = storyboard.instantiateViewController(withIdentifier: "PhotoDetailViewControllerId") as! PhotoDetailViewController
    }
    
    func loadView()
    {
        // Apple does not want you to call the loadView() function directly, so they call it behinds the scenes when the view's getter is called.
        window.addSubview(sut.view)
    }
    
    // MARK: Tests
    
    func testViewIntialization()
    {
        loadView()
        XCTAssertNotNil(sut.view)
    }
}
