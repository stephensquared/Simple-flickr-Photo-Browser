//
//  SwiftyJsonTests.swift
//  SimpleFlickrPhotoBrowser
//
//  Created by Stephen Stephens on 12/22/16.
//  Copyright © 2016 Stephen Stephens. All rights reserved.
//

import Foundation
import XCTest
import Siesta
import SwiftyJSON



class SwiftyJsonTests: XCTestCase {
    
    // MARK: Subject Under Test
    
    var sut: JSON!
    
    // MARK: Test lifecycle
    
    override func setUp() {
        super.setUp()
    }
    
    override func tearDown() {
        super.tearDown()
    }
    
    // MARK: Tests
    
    func testParseAnArrayUsingSwiftyJson1() {
        
        // Example json array
        let jsonData = [
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
        
        sut = JSON(jsonData)
        
        // Get a double from a JSON Array.
        let testDouble = sut["array"][0].double
        XCTAssertTrue(testDouble == 12.34)
        // Get an array of string from a JSON Array.
        let arrayOfString = sut["users"].arrayValue.map({$0["info"]["name"]})
        XCTAssertTrue(arrayOfString.count == 2)
        // Get a string using a path to the element.
        if let name1 = sut["users",1,"info","name"].string {
            XCTAssertTrue(name1 == "jeffgukang")
        } else {
            XCTFail("Unable to parse name from jsonArray")
        }
        // Get the name string using the custom way.
        let keys: [JSONSubscriptType] = ["users", 1, "info", "name"]
        if let name2 = sut[keys].string {
            XCTAssertTrue(name2 == "jeffgukang")
        } else {
            XCTFail("Unable to parse name from jsonArray")
        }
        // Get the name string using another custom way.
        if let name3 = sut["users"][1]["info"]["name"].string {
            XCTAssertTrue(name3 == "jeffgukang")
        } else {
            XCTFail("Unable to parse name from jsonArray")
        }
        // Get the name string using a third custom way.
        if let name4 = sut["users",1,"info","name"].string {
            XCTAssertTrue(name4 == "jeffgukang")
        } else {
            XCTFail("Unable to parse name from jsonArray")
        }
    }
    
    func testParseSampleApiResponse(){
        if let file = Bundle.main.path(forResource: "ApiResponseSample", ofType: "json") {
            if let jsonData = try? Data(contentsOf: URL(fileURLWithPath: file)) {
                
                sut = JSON(data: jsonData)
                let statString = sut["stat"].stringValue
                XCTAssertTrue(statString == "ok")
                let idString = sut["photos","photo",1,"id"].string
                XCTAssertTrue(idString == "30864869653")
                let ownerString = sut["photos","photo",1,"owner"].string
                XCTAssertTrue(ownerString == "55740718@N03")
                let secretString = sut["photos","photo",1,"secret"].string
                XCTAssertTrue(secretString == "1b5820f32c")
                let serverString = sut["photos","photo",1,"server"].string
                XCTAssertTrue(serverString == "489")
                let farmInt = sut["photos","photo",1,"farm"].int
                XCTAssertTrue(farmInt == 1)
                let titleString = sut["photos","photo",1,"title"].string
                XCTAssertTrue(titleString == "Mist by a Smile!")
                let isPublicInt = sut["photos","photo",1,"ispublic"].int
                XCTAssertTrue(isPublicInt == 1)
                let isFriendInt = sut["photos","photo",1,"isfriend"].int
                XCTAssertTrue(isFriendInt == 0)
                let isFamilyInt = sut["photos","photo",1,"isfamily"].int
                XCTAssertTrue(isFamilyInt == 0)
            } else {
                XCTFail("JSON data is nil")
            }
        } else {
            XCTFail("ApiResponseSample.json failed to load properly.")
        }
    }
}
