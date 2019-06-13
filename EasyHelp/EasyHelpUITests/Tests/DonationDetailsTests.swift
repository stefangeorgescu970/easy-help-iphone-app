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
            XCTAssertEqual(donationDetailsPage.getTitleText(), "Blood Donation")
            XCTAssertEqual(donationDetailsPage.getSubtitleText(), getTodayFormatted())
            XCTAssertEqual(donationDetailsPage.hospitalIconExists(), true)
            XCTAssertEqual(donationDetailsPage.getNameText(), "DC")
            XCTAssertEqual(donationDetailsPage.getCountyText(), "ALBA")
            XCTAssertEqual(donationDetailsPage.getAddressText(), "some street")
            XCTAssertEqual(donationDetailsPage.getResultsTitleText(), "Test Results")
            XCTAssertEqual(donationDetailsPage.getResultsSubtitleText(), "Test results are not yet available.")
            
            let (left, right) = donationDetailsPage.getRowInfo(atIndex: 0)
            XCTAssertEqual(left, nil)
            XCTAssertEqual(right, nil)
            
            XCTAssertEqual(donationDetailsPage.getMedicRecommandationText(), nil)
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
            XCTAssertEqual(donationDetailsPage.getTitleText(), "Blood Donation")
            XCTAssertEqual(donationDetailsPage.getSubtitleText(), getTodayFormatted())
            XCTAssertEqual(donationDetailsPage.hospitalIconExists(), true)
            XCTAssertEqual(donationDetailsPage.getNameText(), "DC")
            XCTAssertEqual(donationDetailsPage.getCountyText(), "ALBA")
            XCTAssertEqual(donationDetailsPage.getAddressText(), "some street")
            XCTAssertEqual(donationDetailsPage.getResultsTitleText(), "Test Results")
            XCTAssertEqual(donationDetailsPage.getResultsSubtitleText(), nil)
            
            var (left, right) = donationDetailsPage.getRowInfo(atIndex: 0)
            XCTAssertEqual(left, "ALT")
            XCTAssertEqual(right, "Negative")
            
            (left, right) = donationDetailsPage.getRowInfo(atIndex: 1)
            XCTAssertEqual(left, "HIV")
            XCTAssertEqual(right, "Negative")
            
            (left, right) = donationDetailsPage.getRowInfo(atIndex: 2)
            XCTAssertEqual(left, "HTLV")
            XCTAssertEqual(right, "Negative")
            
            (left, right) = donationDetailsPage.getRowInfo(atIndex: 3)
            XCTAssertEqual(left, "Hepatitis B")
            XCTAssertEqual(right, "Negative")
            
            (left, right) = donationDetailsPage.getRowInfo(atIndex: 4)
            XCTAssertEqual(left, "Hepatitis C")
            XCTAssertEqual(right, "Negative")
            
            (left, right) = donationDetailsPage.getRowInfo(atIndex: 5)
            XCTAssertEqual(left, "VDRL")
            XCTAssertEqual(right, "Negative")
            
            (left, right) = donationDetailsPage.getRowInfo(atIndex: 6)
            XCTAssertEqual(left, nil)
            XCTAssertEqual(right, nil)
            
            XCTAssertEqual(donationDetailsPage.getMedicRecommandationText(), nil)
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
            XCTAssertEqual(donationDetailsPage.getTitleText(), "Blood Donation")
            XCTAssertEqual(donationDetailsPage.getSubtitleText(), getTodayFormatted())
            XCTAssertEqual(donationDetailsPage.hospitalIconExists(), true)
            XCTAssertEqual(donationDetailsPage.getNameText(), "DC")
            XCTAssertEqual(donationDetailsPage.getCountyText(), "ALBA")
            XCTAssertEqual(donationDetailsPage.getAddressText(), "some street")
            XCTAssertEqual(donationDetailsPage.getResultsTitleText(), "Test Results")
            XCTAssertEqual(donationDetailsPage.getResultsSubtitleText(), nil)
            
            var (left, right) = donationDetailsPage.getRowInfo(atIndex: 0)
            XCTAssertEqual(left, "ALT")
            XCTAssertEqual(right, "Negative")
            
            (left, right) = donationDetailsPage.getRowInfo(atIndex: 1)
            XCTAssertEqual(left, "HIV")
            XCTAssertEqual(right, "Positive")
            
            (left, right) = donationDetailsPage.getRowInfo(atIndex: 2)
            XCTAssertEqual(left, "HTLV")
            XCTAssertEqual(right, "Negative")
            
            (left, right) = donationDetailsPage.getRowInfo(atIndex: 3)
            XCTAssertEqual(left, "Hepatitis B")
            XCTAssertEqual(right, "Negative")
            
            (left, right) = donationDetailsPage.getRowInfo(atIndex: 4)
            XCTAssertEqual(left, "Hepatitis C")
            XCTAssertEqual(right, "Negative")
            
            (left, right) = donationDetailsPage.getRowInfo(atIndex: 5)
            XCTAssertEqual(left, "VDRL")
            XCTAssertEqual(right, "Negative")
            
            (left, right) = donationDetailsPage.getRowInfo(atIndex: 6)
            XCTAssertEqual(left, nil)
            XCTAssertEqual(right, nil)
            
            XCTAssertEqual(donationDetailsPage.getMedicRecommandationText(), "It is recommended that you get in touch with your doctor as soon as possible.")
        }
        
        XCTContext.runActivity(named: "finishing test") { _ in
            donationDetailsPage.swipeToGoBack(shouldGoTo: DonationDetailsCasesControllerPage.self)
            XCTAssert(casesPage.isVisible())
        }
    }
    
    private func getTodayFormatted() -> String {
        let formatter = DateFormatter()
        formatter.dateFormat = "E, d MMM yyyy"
        
        return "from \(formatter.string(from: Date()))"
    }
}
