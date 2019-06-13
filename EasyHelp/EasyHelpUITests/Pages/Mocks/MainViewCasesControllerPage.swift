//
//  MainViewCasesControllerPage.swift
//  EasyHelpUITests
//
//  Created by Stefan Georgescu on 13/06/2019.
//  Copyright © 2019 EasyHelp. All rights reserved.
//

import Foundation
import XCTest

class MainViewCasesControllerPage: Page {
    
    // MARK: - Singleton and Abstract Parent Class Declarations
    
    private typealias AccIds = TestStrings.Mocks.MainViewCasesController
    private static let privateSharedInstance = MainViewCasesControllerPage(shouldWaitForPageLoad: false)
    
    override class var sharedInstance: MainViewCasesControllerPage {
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
    
    lazy private var hasMaxDonationsSwitch: XCUIElement = { return self.rootElement.switches[AccIds.hasMaxDonationsSwitch] }()
    lazy private var hasRecentlyDonatedSwitch: XCUIElement = { return self.rootElement.switches[AccIds.hasRecentlyDonatedSwitch] }()
    lazy private var hasBookingSwitch: XCUIElement = { return self.rootElement.switches[AccIds.hasBookingSwitch] }()
    lazy private var canHelpDonorsSwitch: XCUIElement = {return self.rootElement.switches[AccIds.canHelpDonorSwitch] }()
    lazy private var showViewCell: XCUIElement = { return self.rootElement.staticTexts[AccIds.showViewCell] }()
    
    // MARK: - Interacting with page content
    
    @discardableResult
    func tapHasMaxDonationsSwitch() -> MainViewCasesControllerPage {
        self.hasMaxDonationsSwitch.tap()
        return self
    }
    
    @discardableResult
    func tapHasRecentlyDonatedSwitch() -> MainViewCasesControllerPage {
        self.hasRecentlyDonatedSwitch.tap()
        return self
    }
    
    @discardableResult
    func tapHasBookingSwitch() -> MainViewCasesControllerPage {
        self.hasBookingSwitch.tap()
        return self
    }
    
    @discardableResult
    func tapCanHelpDonorsSwitch() -> MainViewCasesControllerPage {
        self.canHelpDonorsSwitch.tap()
        return self
    }
    
    @discardableResult
    func tapShowViewCell() -> MainScreenViewPage {
        self.showViewCell.tap()
        return MainScreenViewPage.sharedInstance
    }
    
    // MARK: Helper methods
    
    func setInitialValues() {
        if ((self.hasMaxDonationsSwitch.value as! String) == "1") {
            self.tapHasMaxDonationsSwitch()
        }
        if ((self.hasRecentlyDonatedSwitch.value as! String) == "1") {
            self.tapHasRecentlyDonatedSwitch()
        }
        if ((self.hasBookingSwitch.value as! String) == "1") {
            self.tapHasBookingSwitch()
        }
        if ((self.canHelpDonorsSwitch.value as! String) == "1") {
            self.tapCanHelpDonorsSwitch()
        }
    }
}
