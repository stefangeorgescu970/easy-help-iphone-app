//
//  DonationDetailsTests.swift
//  EasyHelpUITests
//
//  Created by Stefan Georgescu on 13/06/2019.
//  Copyright © 2019 EasyHelp. All rights reserved.
//

import XCTest

class DonationDetailsTests: XCTestCase {
    // MARK: - Setup of Test Case
    
    static var app: XCUIApplication?
    let casesPage = DonationDetailsCasesControllerPage.sharedInstance
    
    override func setUp() {
        super.setUp()
        continueAfterFailure = false
        
        if DonationDetailsTests.app == nil {
            DonationDetailsTests.app = XCUIApplication()
            DonationDetailsTests.app!.launch()
            MainMocksPage.sharedInstance.tapDonationDetailsControllerCell()
        }
        
        casesPage.setInitialValues()
    }
    
    override func tearDown() {
        super.tearDown()
        
        if testRun?.failureCount ?? 0 > 0 {
            DonationDetailsTests.app?.terminate()
            DonationDetailsTests.app = XCUIApplication()
            DonationDetailsTests.app!.launch()
            MainMocksPage.sharedInstance.tapDonationDetailsControllerCell()
        }
    }
    
    // MARK: - Actual test functions
    
    func testDonationDetailsNoResults() {
        let donationDetailsPage = XCTContext.runActivity(named: "navigating to donation details view") { (_) -> DonationDetailsPage in
            return casesPage.tapShowViewCell()
        }
        
        XCTContext.runActivity(named: "testing main view page content") { _ in
            XCTAssert(donationDetailsPage.isVisible())
        }
        
        XCTContext.runActivity(named: "finishing test") { _ in
            donationDetailsPage.swipeToGoBack(shouldGoTo: DonationDetailsCasesControllerPage.self)
            XCTAssert(casesPage.isVisible())
        }
    }
    
    func testDonationDetailsGoodResults() {
        let donationDetailsPage = XCTContext.runActivity(named: "navigating to donation details view") { (_) -> DonationDetailsPage in
            return casesPage.tapHasResultsSwitch().tapShowViewCell()
        }
        
        XCTContext.runActivity(named: "testing main view page content") { _ in
            XCTAssert(donationDetailsPage.isVisible())
        }
        
        XCTContext.runActivity(named: "finishing test") { _ in
            donationDetailsPage.swipeToGoBack(shouldGoTo: DonationDetailsCasesControllerPage.self)
            XCTAssert(casesPage.isVisible())
        }
    }
    
    func testDonationDetailsBadResults() {
        let donationDetailsPage = XCTContext.runActivity(named: "navigating to donation details view") { (_) -> DonationDetailsPage in
            return casesPage.tapHasResultsSwitch().tapHasBadResultsSwitch().tapShowViewCell()
        }
        
        XCTContext.runActivity(named: "testing main view page content") { _ in
            XCTAssert(donationDetailsPage.isVisible())
        }
        
        XCTContext.runActivity(named: "finishing test") { _ in
            donationDetailsPage.swipeToGoBack(shouldGoTo: DonationDetailsCasesControllerPage.self)
            XCTAssert(casesPage.isVisible())
        }
    }
}
