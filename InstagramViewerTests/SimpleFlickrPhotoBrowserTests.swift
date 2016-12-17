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

enum jsonParsingError: Error {
    case generalError
}

class SimpleFlickrPhotoBrowserTests: XCTestCase {
    
    override func setUp() {
        super.setUp()
        
        /* TODO: Setup an event listener to detect this image update and validate the test.
        let testImage = RemoteImageView()
        testImage.imageURL = "http://farm2.staticflickr.com/1103/567229075_2cf8456f01_n.jpg"
        */

    }
    
    override func tearDown() {
        // This method is called after the invocation of each test method in the class.
        super.tearDown()
    }

    /// A sanity check to make sure that the simple JSON text in the file correctly parses
    /// uning the built in JSONSerialization tool.
    func testBuiltInJsonPhotoParse(){
        
        // Sample data is stored in the SinglePhotoJsonDataSample.json file
        let filepath = Bundle.main.path(forResource: "SinglePhotoJsonDataSample", ofType: ".json")
        
        do {
            // Load and parse the JSON data
            let fileContents = try String(contentsOfFile: filepath!)
            let data = fileContents.data(using: .utf8)!
            let json = try? JSONSerialization.jsonObject(with: data, options: []) as! [String: AnyObject]

            if let idValue = json?["id"] as? String {
                XCTAssertTrue(idValue == "31313032270")
            } else {
                XCTFail("BuiltInJsonPhotoParse fail: Incorrect ID value")
            }
            
            if let idValue = json?["owner"] as? String {
                XCTAssertTrue(idValue == "33573751@N04")
            } else {
                XCTFail("BuiltInJsonPhotoParse fail: Incorrect owner value")
            }
            
            if let idValue = json?["secret"] as? String {
                XCTAssertTrue(idValue == "ffbc3c1f5e")
            } else {
                XCTFail("BuiltInJsonPhotoParse fail: Incorrect secret value")
            }
            
            if let idValue = json?["server"] as? String {
                XCTAssertTrue(idValue == "159")
            } else {
                XCTFail("BuiltInJsonPhotoParse fail: Incorrect server value")
            }
            
            if let idValue = json?["farm"] as? Int {
                XCTAssertTrue(idValue == 1)
            } else {
                XCTFail("BuiltInJsonPhotoParse fail: Incorrect farm value")
            }
            
            if let idValue = json?["title"] as? String {
                XCTAssertTrue(idValue == "Magnificent Hummingbird (Eugenes fulgens) (EXPLORE December 17, 2016) - Please View Large")
            } else {
                XCTFail("BuiltInJsonPhotoParse fail: Incorrect title value")
            }

        } catch {
            XCTFail("JSON Test file (SinglePhotoJsonDataSample.JSON) not loading properly.")
        }
    }
    
    func testParseApiResponseSample(){
        
        // Sample data is stored in the SinglePhotoJsonDataSample.json file
        let filepath = Bundle.main.path(forResource: "ApiResponseSample", ofType: ".json")
        
        do {
            let fileContents = try String(contentsOfFile: filepath!)

            do {
                
                let parsedResponse = try FlickrOuterJsonWrapper(json: JSON(fileContents))
                    
                if parsedResponse.stat != "ok" {
                   XCTFail("ParseApiResponseSample fail: parsing photos is nil")
                }
                
                if parsedResponse.photos == nil {
                    XCTFail("ParseApiResponseSample fail: parsing photos is nil")
                } else {
                
                    // TODO: Figure out why parsing of sample API response text isn't being parsed properly.
                    // Why isn't this working?
                    // Setup a SwiftyJSON example that reads from a file.
                }
            } catch jsonParsingError.generalError {
                XCTFail("ParseApiResponseSample fail: JSON parsing error")
            } catch {
                // Need this to be exhaustive with respect to error cases.
                XCTFail("ParseApiResponseSample fail: JSON parsing error")
            }
            
        } catch {
            XCTFail("ParseApiResponseSample fail: JSON Test file (SinglePhotoJsonDataSample.JSON) not loading properly.")
        }
    }
    
    func testPerformanceExample() {
        self.measure {
            print("I Wonder how long this takes to print?")
        }
    }
    
}
