//
//  DonationDetailsPage.swift
//  EasyHelpUITests
//
//  Created by Stefan Georgescu on 13/06/2019.
//  Copyright © 2019 EasyHelp. All rights reserved.
//

import Foundation
import XCTest

class DonationDetailsPage: Page {
    
    // MARK: - Singleton and Abstract Parent Class Declarations
    
    private typealias AccIds = TestStrings.App.DonationDetails
    private static let privateSharedInstance = DonationDetailsPage(shouldWaitForPageLoad: false)
    
    override class var sharedInstance: DonationDetailsPage {
        privateSharedInstance.waitForPage()
        return privateSharedInstance
    }
    
    override internal var rootElement: XCUIElement {
        return Page.app.scrollViews[AccIds.view]
    }
    
    private override init(shouldWaitForPageLoad: Bool, timeout: TimeInterval = 5) {
        super.init(shouldWaitForPageLoad: shouldWaitForPageLoad, timeout: timeout)
    }
    
    // MARK: - UI elements declaration
    
   
    // MARK: - Access page content
    
  
    // MARK: - Interacting with page content
    

}
