//
//  SimpleFlickrPhotoBrowserUITests.swift
//  SimpleFlickrPhotoBrowser
//
//  Created by Stephen Stephens on 12/8/16.
//  Copyright © 2016 Stephen Stephens. All rights reserved.
//

import XCTest

class UITests: UITestCase {
    
    func testTypingTextInSearchField() {
        let textField = app.textFields["SearchTextBarAccessibilityLabel"]
        textField.tap()
        textField.typeText("rainbow Eucalyptus")
    }

    func testInterestingButtonTap(){
        app.buttons["Interesting"].tap()
    }
    
    func testSearchWithEmptyString(){
        app.buttons["Search"].tap()
    }
    
    func testTextSearch() {
        let navnTextField = app.textFields["SearchTextBarAccessibilityLabel"]
        navnTextField.tap()
        UIPasteboard.general.string = "Rainbow Eucalyptus"
        navnTextField.doubleTap()
        app.menuItems.element(boundBy: 0).tap() // Select "Paste" from the menu
        app.buttons["Search"].tap()
        let resultsTextLabel = app.textFields["SearchTextBarAccessibilityLabel"]
        waitForElementToAppear(resultsTextLabel)
        XCTAssert(resultsTextLabel.exists)
    }
    
    func testSwipeDown() {
        let start = app.coordinate(withNormalizedOffset: CGVector(dx: 1, dy: 12))
        let finish = app.coordinate(withNormalizedOffset: CGVector(dx: 1, dy: 0))
        start.press(forDuration: 0, thenDragTo: finish)
        app.buttons["Interesting"].tap()
    }
    
    func testTapFirstPhotoThenZoom() {
        app.collectionViews.children(matching: .cell).element(boundBy: 0).otherElements.children(matching: .image).element.tap()
        let scale: CGFloat = 10
        let velocity: CGFloat = 10
        app.scrollViews.children(matching: .image).element.pinch(withScale: scale, velocity: velocity)
    }
}
