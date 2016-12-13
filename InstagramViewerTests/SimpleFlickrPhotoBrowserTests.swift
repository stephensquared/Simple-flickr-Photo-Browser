//
//  SimpleFlickrPhotoBrowser
//  SimpleFlickrPhotoBrowserTests.swift
//
//  Created by Stephen Stephens on 12/8/16.
//  Copyright © 2016 Stephen Stephens. All rights reserved.
//

import Foundation
import XCTest
import Siesta
import SwiftyJSON

@testable import SimpleFlickrPhotoBrowser

class SimpleFlickrPhotoBrowserTests: XCTestCase {
    
    override func setUp() {
        super.setUp()
        
        /* TODO: Setup an event listener to detect this image update and validate the test.
        let testImage = RemoteImageView()
        testImage.imageURL = "http://farm2.staticflickr.com/1103/567229075_2cf8456f01_n.jpg"
        */
        
        // Initialize the FlickApi to search for interesting photos.
        // This triggers the photoListResource didSet listener and the resource is updated.
        //var photoListResource = FlickrApi.interestingPhotos
        
        // Assert that the resource initialized properly.
       // XCTAssertTrue(photoListResource != nil)
        //
    }
    
    override func tearDown() {
        // Put teardown code here. This method is called after the invocation of each test method in the class.
        super.tearDown()
    }
    
//    func testJsonParsing01() {
//        
//        enum jsonParsingError: Error {
//            case generalError
//        }
//        
//        let jsonString = "{\"id\":\"30760536664\",\"owner\":\"127597661@N02\",\"secret\":\"422037e447\",\"server\":\"457\",\"farm\":1,\"title\":\"DanLNeville: RT sflakesoftware: We'recelebratinGingerbreadHouseDaatnowflakeHQ!https:fPPbAGZ2jJ\",\"ispublic\":1,\"isfriend\":0,\"isfamily\":0}"
//        
//        // The problem here is removing the "\" before trying to parse the JSON.
//        // I've can't find any method in will pull them out before JSON parsing.
//        // TODO: Maybe load a file?
//        print(jsonString)
//        
//        var testPhoto: FlickrPhoto
//
//        do {
//            testPhoto = try FlickrPhoto(json: JSON(jsonString))
//            
//            XCTAssertTrue(testPhoto.id == "30760536664")
//            XCTAssertTrue(testPhoto.owner == "127597661@N02")
//            XCTAssertTrue(testPhoto.secret == "422037e447")
//            XCTAssertTrue(testPhoto.server == "457")
//            XCTAssertTrue(testPhoto.farm == 1)
//            XCTAssertTrue(testPhoto.title == "DanLNeville: RT sflakesoftware: We'recelebratinGingerbreadHouseDaatnowflakeHQ!https:fPPbAGZ2jJ")
//            
//        } catch jsonParsingError.generalError {
//            XCTFail("JSON Parsing Test Error")
//        } catch {
//            XCTFail("JSON Parsing Test Error")
//        }
//    }
    
    func testPerformanceExample() {
        // This is an example of a performance test case.
        self.measure {
            // Put the code you want to measure the time of here.
        }
    }
    
}
