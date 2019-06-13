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
    
    lazy private var titleLabel: XCUIElement = { return self.rootElement.staticTexts[AccIds.title] }()
    lazy private var subtitleLabel: XCUIElement = { return self.rootElement.staticTexts[AccIds.subtitle] }()
    lazy private var hospitalIcon: XCUIElement = { return self.rootElement.images[AccIds.hospitalIcon] }()
    lazy private var nameLabel: XCUIElement = { return self.rootElement.staticTexts[AccIds.name] }()
    lazy private var countyLabel: XCUIElement = { return self.rootElement.staticTexts[AccIds.county] }()
    lazy private var addressButton: XCUIElement = { return self.rootElement.buttons[AccIds.address] }()
    lazy private var resultsTitleLabel: XCUIElement = { return self.rootElement.staticTexts[AccIds.resultsTitle] }()
    lazy private var resultsSubtitleLabel: XCUIElement = { return self.rootElement.staticTexts[AccIds.resultsSubtitle] }()
    lazy private var medicRecoLabel: XCUIElement = { return self.rootElement.staticTexts[AccIds.medicReco] }()
   
    // MARK: - Access page content
    
    func getTitleText() -> String? {
        return PageUtils.getStringOptional(fromElement: titleLabel)
    }
    
    func getSubtitleText() -> String? {
        return PageUtils.getStringOptional(fromElement: subtitleLabel)
    }
    
    func hospitalIconExists() -> Bool {
        return hospitalIcon.exists
    }
    
    func getNameText() -> String? {
        return PageUtils.getStringOptional(fromElement: nameLabel)
    }
    
    func getCountyText() -> String? {
        return PageUtils.getStringOptional(fromElement: countyLabel)
    }
    
    func getAddressText() -> String? {
        return PageUtils.getStringOptional(fromElement: addressButton)
    }
    
    func getResultsTitleText() -> String? {
        return PageUtils.getStringOptional(fromElement: resultsTitleLabel)
    }
    
    func getResultsSubtitleText() -> String? {
        return PageUtils.getStringOptional(fromElement: resultsSubtitleLabel)
    }
    
    func getRowInfo(atIndex: Int) -> (left: String?, right: String?) {
        let left = PageUtils.getStringOptional(fromElement: rootElement.staticTexts["\(atIndex)-left\(AccIds.rowStub)"])
        let right = PageUtils.getStringOptional(fromElement: rootElement.staticTexts["\(atIndex)-right\(AccIds.rowStub)"])
        
        return (left, right)
    }
    
    func getMedicRecommandationText() -> String? {
        return PageUtils.getStringOptional(fromElement: medicRecoLabel)
    }
}
