//
//  MainScreenViewTests.swift
//  EasyHelpUITests
//
//  Created by Stefan Georgescu on 13/06/2019.
//  Copyright © 2019 EasyHelp. All rights reserved.
//

import XCTest

class MainScreenViewTests: XCTestCase {
    
    // MARK: - Setup of Test Case
    
    static var app: XCUIApplication?
    let casesPage = MainViewCasesControllerPage.sharedInstance
    
    override func setUp() {
        super.setUp()
        continueAfterFailure = false
        
        if MainScreenViewTests.app == nil {
            MainScreenViewTests.app = XCUIApplication()
            MainScreenViewTests.app!.launch()
            MainMocksPage.sharedInstance.tapMainViewControllerCell()
        }
        
        casesPage.setInitialValues()
    }
    
    override func tearDown() {
        super.tearDown()
        
        if testRun?.failureCount ?? 0 > 0 {
            MainScreenViewTests.app?.terminate()
            MainScreenViewTests.app = XCUIApplication()
            MainScreenViewTests.app!.launch()
            MainMocksPage.sharedInstance.tapMainViewControllerCell()
        }
    }
    
    // MARK: - Actual test functions
    
    func testDefaultView() {
        let mainScreenPage = XCTContext.runActivity(named: "navigating to main view") { (_) -> MainScreenViewPage in
            return casesPage.tapShowViewCell()
        }
        
        XCTContext.runActivity(named: "testing main view page content") { _ in
            XCTAssert(mainScreenPage.isVisible())
        }
        
        XCTContext.runActivity(named: "finishing test") { _ in
            mainScreenPage.swipeToGoBack(shouldGoTo: MainViewCasesControllerPage.self)
            XCTAssert(casesPage.isVisible())
        }
    }
    
    func testDefaultCanHelpView() {
        let mainScreenPage = XCTContext.runActivity(named: "navigating to main view") { (_) -> MainScreenViewPage in
            return casesPage.tapCanHelpDonorsSwitch().tapShowViewCell()
        }
        
        XCTContext.runActivity(named: "testing main view page content") { _ in
            XCTAssert(mainScreenPage.isVisible())
        }
        
        XCTContext.runActivity(named: "finishing test") { _ in
            mainScreenPage.swipeToGoBack(shouldGoTo: MainViewCasesControllerPage.self)
            XCTAssert(casesPage.isVisible())
        }
    }
    
    func testMaxDonationsView() {
        let mainScreenPage = XCTContext.runActivity(named: "navigating to main view") { (_) -> MainScreenViewPage in
            return casesPage.tapHasMaxDonationsSwitch().tapShowViewCell()
        }
        
        XCTContext.runActivity(named: "testing main view page content") { _ in
            XCTAssert(mainScreenPage.isVisible())
        }
        
        XCTContext.runActivity(named: "finishing test") { _ in
            mainScreenPage.swipeToGoBack(shouldGoTo: MainViewCasesControllerPage.self)
            XCTAssert(casesPage.isVisible())
        }
    }
    
    func testHasRecentlyDonatedView() {
        let mainScreenPage = XCTContext.runActivity(named: "navigating to main view") { (_) -> MainScreenViewPage in
            return casesPage.tapHasRecentlyDonatedSwitch().tapShowViewCell()
        }
        
        XCTContext.runActivity(named: "testing main view page content") { _ in
            XCTAssert(mainScreenPage.isVisible())
        }
        
        XCTContext.runActivity(named: "finishing test") { _ in
            mainScreenPage.swipeToGoBack(shouldGoTo: MainViewCasesControllerPage.self)
            XCTAssert(casesPage.isVisible())
        }
    }
    
    func testHasBookingView() {
        let mainScreenPage = XCTContext.runActivity(named: "navigating to main view") { (_) -> MainScreenViewPage in
            return casesPage.tapHasBookingSwitch().tapShowViewCell()
        }
        
        XCTContext.runActivity(named: "testing main view page content") { _ in
            XCTAssert(mainScreenPage.isVisible())
        }
        
        XCTContext.runActivity(named: "finishing test") { _ in
            mainScreenPage.swipeToGoBack(shouldGoTo: MainViewCasesControllerPage.self)
            XCTAssert(casesPage.isVisible())
        }
    }
}
