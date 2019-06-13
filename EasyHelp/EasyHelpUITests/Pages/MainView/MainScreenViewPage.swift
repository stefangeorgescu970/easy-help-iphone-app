//
//  MainScreenViewPage.swift
//  EasyHelpUITests
//
//  Created by Stefan Georgescu on 13/06/2019.
//  Copyright © 2019 EasyHelp. All rights reserved.
//

import Foundation
import XCTest

class MainScreenViewPage: Page {
    
    // MARK: - Singleton and Abstract Parent Class Declarations
    
    private typealias AccIds = TestStrings.App.MainScreen
    private static let privateSharedInstance = MainScreenViewPage(shouldWaitForPageLoad: false)
    
    override class var sharedInstance: MainScreenViewPage {
        privateSharedInstance.waitForPage()
        return privateSharedInstance
    }
    
    override internal var rootElement: XCUIElement {
        return Page.app.otherElements[AccIds.view]
    }
    
    private override init(shouldWaitForPageLoad: Bool, timeout: TimeInterval = 5) {
        super.init(shouldWaitForPageLoad: shouldWaitForPageLoad, timeout: timeout)
    }
    
    // MARK: - UI elements declaration
    
   
    
    // MARK: - Access page content
    

    
    // MARK: - Interacting with page content
    

}
