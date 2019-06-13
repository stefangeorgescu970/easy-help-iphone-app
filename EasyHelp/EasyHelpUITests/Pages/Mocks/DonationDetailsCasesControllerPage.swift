//
//  DonationDetailsCasesControllerPage.swift
//  EasyHelpUITests
//
//  Created by Stefan Georgescu on 13/06/2019.
//  Copyright © 2019 EasyHelp. All rights reserved.
//

import Foundation
import XCTest

class DonationDetailsCasesControllerPage: Page {
    
    // MARK: - Singleton and Abstract Parent Class Declarations
    
    private typealias AccIds = TestStrings.Mocks.DonationDetailsCasesController
    private static let privateSharedInstance = DonationDetailsCasesControllerPage(shouldWaitForPageLoad: false)
    
    override class var sharedInstance: DonationDetailsCasesControllerPage {
        privateSharedInstance.waitForPage()
        return privateSharedInstance
    }
    
    override internal var rootElement: XCUIElement {
        return Page.app.tables[AccIds.view]
    }
    
    private override init(shouldWaitForPageLoad: Bool, timeout: TimeInterval = 5) {
        super.init(shouldWaitForPageLoad: shouldWaitForPageLoad, timeout: timeout)
    }
    
    // MARK: - UI elements declaration
    
    lazy private var hasResultsSwitch: XCUIElement = { return self.rootElement.switches[AccIds.hasResultsSwitch] }()
    lazy private var hasBadResultsSwitch: XCUIElement = { return self.rootElement.switches[AccIds.areResultsBadSwitch] }()
    lazy private var showViewCell: XCUIElement = { return self.rootElement.staticTexts[AccIds.showViewCell] }()
    
    // MARK: - Interacting with page content
    
    @discardableResult
    func tapHasResultsSwitch() -> DonationDetailsCasesControllerPage {
        self.hasResultsSwitch.tap()
        return self
    }
    
    @discardableResult
    func tapHasBadResultsSwitch() -> DonationDetailsCasesControllerPage {
        self.hasBadResultsSwitch.tap()
        return self
    }
    
    @discardableResult
    func tapShowViewCell() -> DonationDetailsPage {
        self.showViewCell.tap()
        return DonationDetailsPage.sharedInstance
    }
    
    // MARK: Helper methods
    
    func setInitialValues() {
        if ((self.hasResultsSwitch.value as! String) == "1") {
            self.tapHasResultsSwitch()
        }
        if ((self.hasBadResultsSwitch.value as! String) == "1") {
            self.tapHasBadResultsSwitch()
        }
    }
}
