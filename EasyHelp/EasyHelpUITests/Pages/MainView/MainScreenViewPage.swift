//
//  MainScreenViewPage.swift
//  EasyHelpUITests
//
//  Created by Stefan Georgescu on 13/06/2019.
//  Copyright © 2019 EasyHelp. All rights reserved.
//

import Foundation
import XCTest

class MainScreenViewPage: Page, MainScreenCanBookPage, MainScreenNextBookingPage, MainScreenTooManyDonationsPage, MainScreenRecentDonationPage {
    
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
    
    lazy private var logoLabel: XCUIElement = { return self.rootElement.staticTexts[AccIds.logo] }()
    lazy private var nameLabel: XCUIElement = { return self.rootElement.staticTexts[AccIds.name] }()
    lazy private var donatedLabel: XCUIElement = { return self.rootElement.staticTexts[AccIds.donated] }()
    lazy private var encourageLabel: XCUIElement = { return self.rootElement.staticTexts[AccIds.encourage] }()
    lazy private var whyButton: XCUIElement = { return self.rootElement.buttons[AccIds.whyButton] }()
    lazy private var howButton: XCUIElement = { return self.rootElement.buttons[AccIds.howButton] }()
    
    // MARK: - Access page content
    
    func getLogoText() -> String? {
        return PageUtils.getStringOptional(fromElement: logoLabel)
    }
    
    func getNameText() -> String? {
        return PageUtils.getStringOptional(fromElement: nameLabel)
    }
    
    func getDonatedLabelText() -> String? {
        return PageUtils.getStringOptional(fromElement: donatedLabel)
    }
    
    func getEncourageLabelText() -> String? {
        return PageUtils.getStringOptional(fromElement: encourageLabel)
    }
    
    func whyButtonExists() -> Bool {
        return whyButton.exists
    }
    
    func howButtonExists() -> Bool {
        return howButton.exists
    }
}
