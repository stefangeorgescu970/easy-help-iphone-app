//
//  Page.swift
//  EasyHelpUITests
//
//  Created by Stefan Georgescu on 13/06/2019.
//  Copyright © 2019 EasyHelp. All rights reserved.
//

import Foundation
import XCTest

class Page {
    
    // MARK: -Abstract Class Declarations
    
    private var shouldWaitForPage: Bool
    private var waitTimeout: TimeInterval
    
    var rootElement: XCUIElement { fatalError("subclass should override rootElement") }
    
    class var sharedInstance: Page {
        fatalError("subclass should override sharedUbstabce")
    }
    
    init(shouldWaitForPageLoad: Bool, timeout: TimeInterval = 5) {
        self.shouldWaitForPage = shouldWaitForPageLoad
        self.waitTimeout = timeout
        waitForPage()
    }
    
    // MARK: - UI elements declaration
    
    internal static let app = XCUIApplication()
    
    // MARK: - Access page content
    
    func appDisplayedAlert() -> Bool{
        return Page.app.alerts.count != 0
    }
    
    func getAlertMessage() -> String? {
        return PageUtils.getStringOptional(fromRootElement: Page.app.alerts.firstMatch, staticTextIndex: 1) // 0 is the title
    }
    
    func isVisible() -> Bool {
        return self.rootElement.exists && self.rootElement.isHittable
    }
    
    func appDisplayedSheet() -> Bool {
        return Page.app.sheets.count != 0
    }
    
    func getSheetTitleLabel() -> String? {
        return PageUtils.getStringOptional(fromElement: Page.app.sheets.firstMatch)
    }
    
    // MARK: - Interacting with page content
    
    func dismissOneButtonAlert() {
        Page.app.alerts.buttons.firstMatch.tap()
    }
    
    func goBack() -> Page {
        fatalError("subclass should override goBack")
    }
    
    @discardableResult
    func tapSheetButtonWithContent<T: Page>(content: String, shouldReturnTo: T.Type) -> T {
        let button = Page.app.sheets.descendants(matching: .button)[content]
        Page.waitForElementToAppear(button)
        
        button.tap()
        return T.sharedInstance as! T
    }
    
    @discardableResult
    func tapAlertButtonWithContent<T: Page>(content: String, shouldReturnTo: T.Type) -> T {
        let button = Page.app.alerts.buttons[content]
        Page.waitForElementToAppear(button)
        
        button.tap()
        return T.sharedInstance as! T
    }
    
    @discardableResult
    internal func swipeToGoBack<T: Page>(shouldGoTo: T.Type) -> T {
        let coord1 = Page.app.coordinate(withNormalizedOffset: CGVector(dx: 0.01, dy: 0.2))
        let coord2 = coord1.withOffset(CGVector(dx: 300, dy: 0))
        
        coord1.press(forDuration: 0.5, thenDragTo: coord2)
        
        return T.sharedInstance as! T
    }
    
    // MARK: - Helpers
    
    func waitForPage() {
        if shouldWaitForPage {
            let _ = rootElement.waitForExistence(timeout: waitTimeout)
        }
    }
    
    @discardableResult
    static func waitForElementToAppear(_ element: XCUIElement) -> Bool {
        let predicate = NSPredicate(format: "exists == true")
        let expectation = XCTNSPredicateExpectation(predicate: predicate,
                                                    object: element)
        
        let result = XCTWaiter().wait(for: [expectation], timeout: 5)
        return result == .completed
    }
    
    @discardableResult
    static func waitForElementToDisappear(_ element: XCUIElement) -> Bool {
        let predicate = NSPredicate(format: "exists != true")
        let expectation = XCTNSPredicateExpectation(predicate: predicate,
                                                    object: element)
        
        let result = XCTWaiter().wait(for: [expectation], timeout: 5)
        return result == .completed
    }
    
    @discardableResult
    static func waitForAlert() -> Bool {
        let alerts = Page.app.alerts
        
        let predicate = NSPredicate(format: "count != 0")
        let expectation = XCTNSPredicateExpectation(predicate: predicate,
                                                    object: alerts)
        
        let result = XCTWaiter().wait(for: [expectation], timeout: 5)
        return result == .completed
    }
}
