//
//  MainMocksPage.swift
//  EasyHelpUITests
//
//  Created by Stefan Georgescu on 13/06/2019.
//  Copyright © 2019 EasyHelp. All rights reserved.
//

import Foundation
import XCTest

class MainMocksPage: Page {
    
    // MARK: Singleton and Abstract Parent Class Declarations
    
    private typealias AccIds = TestStrings.Mocks.MainTableView
    private static let privateSharedInstance = MainMocksPage(shouldWaitForPageLoad: false)
    
    override class var sharedInstance: MainMocksPage {
        privateSharedInstance.waitForPage()
        return privateSharedInstance
    }
    
    override internal var rootElement: XCUIElement {
        return Page.app.tables[AccIds.view]
    }
    
    private override init(shouldWaitForPageLoad: Bool, timeout: TimeInterval = 5) {
        super.init(shouldWaitForPageLoad: shouldWaitForPageLoad, timeout: timeout)
    }
    
    // MARK: UI elements declaration
    
    lazy private var mainViewControllerCell: XCUIElement = { self.rootElement.staticTexts[AccIds.mainViewCasesCell] }()
    lazy private var donationDetailsControllerCell: XCUIElement = { self.rootElement.staticTexts[AccIds.donationDetailsCasesCell] }()
    
    // MARK: Interacting with page content
    
    @discardableResult
    func tapMainViewControllerCell() -> MainViewCasesControllerPage {
        self.mainViewControllerCell.tap()
        return MainViewCasesControllerPage.sharedInstance
    }
    
    @discardableResult
    func tapDonationDetailsControllerCell() -> DonationDetailsCasesControllerPage {
        self.donationDetailsControllerCell.tap()
        return DonationDetailsCasesControllerPage.sharedInstance
    }
}
