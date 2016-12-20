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
                XCTFail("BuiltInJsonPhotoParse fail: ID value not parsed")
            }
            
            if let idValue = json?["owner"] as? String {
                XCTAssertTrue(idValue == "33573751@N04")
            } else {
                XCTFail("BuiltInJsonPhotoParse fail: owner value not parsed")
            }
            
            if let idValue = json?["secret"] as? String {
                XCTAssertTrue(idValue == "ffbc3c1f5e")
            } else {
                XCTFail("BuiltInJsonPhotoParse fail: secret value not parsed")
            }
            
            if let idValue = json?["server"] as? String {
                XCTAssertTrue(idValue == "159")
            } else {
                XCTFail("BuiltInJsonPhotoParse fail: server value not parsed")
            }
            
            if let idValue = json?["farm"] as? Int {
                XCTAssertTrue(idValue == 1)
            } else {
                XCTFail("BuiltInJsonPhotoParse fail: farm value not parsed")
            }
            
            if let idValue = json?["title"] as? String {
                XCTAssertTrue(idValue == "Magnificent Hummingbird (Eugenes fulgens) (EXPLORE December 17, 2016) - Please View Large")
            } else {
                XCTFail("BuiltInJsonPhotoParse fail: title value not parsed")
            }

        } catch {
            XCTFail("JSON Test file (SinglePhotoJsonDataSample.JSON) not loading properly.")
        }
    }
    
    func testParseAnArrayUsingSwiftyJson(){
        
        // Example json array
        var jsonArray: JSON = [
            "array": [12.34, 56.78],
            "users": [
                [
                    "id": 987654,
                    "info": [
                        "name": "jack",
                        "email": "jack@gmail.com"
                    ],
                    "feeds": [98833, 23443, 213239, 23232]
                ],
                [
                    "id": 654321,
                    "info": [
                        "name": "jeffgukang",
                        "email": "jeffgukang@gmail.com"
                    ],
                    "feeds": [12345, 56789, 12423, 12412]
                ]
            ]
        ]
        
        // Getting a double from a JSON Array
        let testDouble = jsonArray["array"][0].double
        XCTAssertTrue(testDouble == 12.34)
        
        // Getting an array of string from a JSON Array
        let arrayOfString = jsonArray["users"].arrayValue.map({$0["info"]["name"]})
        XCTAssertTrue(arrayOfString.count == 2)
        
        //Getting a string using a path to the element
        var name = jsonArray["users",1,"info","name"].string
        XCTAssertTrue(name! == "jeffgukang")
        
        //With a custom way
        let keys: [JSONSubscriptType] = ["users", 1, "info", "name"]
        name = jsonArray[keys].string
        XCTAssertTrue(name! == "jeffgukang")
        
        //Just the same
        name = jsonArray["users"][1]["info"]["name"].string
        XCTAssertTrue(name! == "jeffgukang")
        
        //Alternatively
        name = jsonArray["users",1,"info","name"].string
        XCTAssertTrue(name! == "jeffgukang")
        
    }
    
    func testParseApiResponseFileUsingSwiftJson(){
        
        var jsonData: Data?
        
        if let file = Bundle.main.path(forResource: "ApiResponseSample", ofType: "json") {
            
            jsonData = try? Data(contentsOf: URL(fileURLWithPath: file))
            let json1 = JSON(data: jsonData!)
        
            let statString = json1["stat"].stringValue
            XCTAssertTrue(statString == "ok")
            
            /*  Look at the photo object at index[1] in the JSON:
            {"id":"30864869653","owner":"55740718@N03","secret":"1b5820f32c","server":"489","farm":1,"title":"Mist by a Smile!","ispublic":1,"isfriend":0,"isfamily":0}
             
            */
            
            let idString = json1["photos","photo",1,"id"].string
            XCTAssertTrue(idString == "30864869653")

            let ownerString = json1["photos","photo",1,"owner"].string
            XCTAssertTrue(ownerString == "55740718@N03")
            
            let secretString = json1["photos","photo",1,"secret"].string
            XCTAssertTrue(secretString == "1b5820f32c")
            
            let serverString = json1["photos","photo",1,"server"].string
            XCTAssertTrue(serverString == "489")
            
            let farmInt = json1["photos","photo",1,"farm"].int
            XCTAssertTrue(farmInt == 1)
            
            let titleString = json1["photos","photo",1,"title"].string
            XCTAssertTrue(titleString == "Mist by a Smile!")
            
            let isPublicInt = json1["photos","photo",1,"ispublic"].int
            XCTAssertTrue(isPublicInt == 1)
            
            let isFriendInt = json1["photos","photo",1,"isfriend"].int
            XCTAssertTrue(isFriendInt == 0)
            
            let isFamilyInt = json1["photos","photo",1,"isfamily"].int
            XCTAssertTrue(isFamilyInt == 0)
            
        } else {
            XCTFail("ApiResponseSample.json failed to load properly.")
        }
    }
    
    func testPerformanceExample() {
        self.measure {
            print("I Wonder how long this takes to print?")
        }
    }
    
}
