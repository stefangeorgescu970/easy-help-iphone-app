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
            XCTAssertEqual(mainScreenPage.getLogoText(), "Easy Help")
            XCTAssertEqual(mainScreenPage.getNameText(), "Stefan Georgescu")
            XCTAssertEqual(mainScreenPage.getDonatedLabelText(), "You have donated 10 times.")
            XCTAssertEqual(mainScreenPage.getEncourageLabelText(), "Did you know that one donation can help up to 3 people? It is a really easy way to help!")
            XCTAssertEqual(mainScreenPage.whyButtonExists(), true)
            XCTAssertEqual(mainScreenPage.howButtonExists(), true)
        }
        
        XCTContext.runActivity(named: "testing subview content") { _ in
            XCTAssertEqual(mainScreenPage.mainScreenCanBookViewExists(), true)
            XCTAssertEqual(mainScreenPage.getMainScreenCanBookViewTitle(), "You are eligible for booking a donation!")
            XCTAssertEqual(mainScreenPage.getMainScreenCanBookViewSubtitle(), nil)
            XCTAssertEqual(mainScreenPage.getMainScreenCanBookViewButtonText(), "Book a Donation")
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
            XCTAssertEqual(mainScreenPage.getLogoText(), "Easy Help")
            XCTAssertEqual(mainScreenPage.getNameText(), "Stefan Georgescu")
            XCTAssertEqual(mainScreenPage.getDonatedLabelText(), "You have donated 10 times.")
            XCTAssertEqual(mainScreenPage.getEncourageLabelText(), "Did you know that one donation can help up to 3 people? It is a really easy way to help!")
            XCTAssertEqual(mainScreenPage.whyButtonExists(), true)
            XCTAssertEqual(mainScreenPage.howButtonExists(), true)
        }
        
        XCTContext.runActivity(named: "testing subview content") { _ in
            XCTAssertEqual(mainScreenPage.mainScreenCanBookViewExists(), true)
            XCTAssertEqual(mainScreenPage.getMainScreenCanBookViewTitle(), "You are eligible for booking a donation!")
            XCTAssertEqual(mainScreenPage.getMainScreenCanBookViewSubtitle(), "5 people need your blood type at this moment.")
            XCTAssertEqual(mainScreenPage.getMainScreenCanBookViewButtonText(), "Book a Donation")
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
            XCTAssertEqual(mainScreenPage.getLogoText(), "Easy Help")
            XCTAssertEqual(mainScreenPage.getNameText(), "Stefan Georgescu")
            XCTAssertEqual(mainScreenPage.getDonatedLabelText(), "You have donated 10 times.")
            XCTAssertEqual(mainScreenPage.getEncourageLabelText(), "Did you know that one donation can help up to 3 people? It is a really easy way to help!")
            XCTAssertEqual(mainScreenPage.whyButtonExists(), true)
            XCTAssertEqual(mainScreenPage.howButtonExists(), true)
        }
        
        XCTContext.runActivity(named: "testing subview content") { _ in
            XCTAssertEqual(mainScreenPage.mainScreenTooManyDonationsViewExists(), true)
            XCTAssertEqual(mainScreenPage.getMainScreenTooManyDonationsViewTitle(), "You are not eligible for donating now")
            XCTAssertEqual(mainScreenPage.getMainScreenTooManyDonationsViewSubtitle(), "You have already donated 5 times this year. You will be able to donate again in 365 days")
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
            XCTAssertEqual(mainScreenPage.getLogoText(), "Easy Help")
            XCTAssertEqual(mainScreenPage.getNameText(), "Stefan Georgescu")
            XCTAssertEqual(mainScreenPage.getDonatedLabelText(), "You have donated 10 times.")
            XCTAssertEqual(mainScreenPage.getEncourageLabelText(), "Did you know that one donation can help up to 3 people? It is a really easy way to help!")
            XCTAssertEqual(mainScreenPage.whyButtonExists(), true)
            XCTAssertEqual(mainScreenPage.howButtonExists(), true)
        }
        
        XCTContext.runActivity(named: "testing subview content") { _ in
            XCTAssertEqual(mainScreenPage.mainScreenRecentDonationViewExists(), true)
            XCTAssertEqual(mainScreenPage.getMainScreenRecentDonationViewTitle(), "You will be able to donate again in 72 days.")
            XCTAssertEqual(mainScreenPage.getMainScreenRecentDonationViewButtonText(), "View Last Donation")
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
            XCTAssertEqual(mainScreenPage.getLogoText(), "Easy Help")
            XCTAssertEqual(mainScreenPage.getNameText(), "Stefan Georgescu")
            XCTAssertEqual(mainScreenPage.getDonatedLabelText(), "You have donated 10 times.")
            XCTAssertEqual(mainScreenPage.getEncourageLabelText(), "Did you know that one donation can help up to 3 people? It is a really easy way to help!")
            XCTAssertEqual(mainScreenPage.whyButtonExists(), true)
            XCTAssertEqual(mainScreenPage.howButtonExists(), true)
        }
        
        XCTContext.runActivity(named: "testing subview content") { _ in
            XCTAssertEqual(mainScreenPage.mainScreenNextBookingViewExists(), true)
            XCTAssertEqual(mainScreenPage.getMainScreenNextBookingViewDate(), getBookingIntervalTomorrowAt9())
            XCTAssertEqual(mainScreenPage.getMainScreenNextBookingViewTitle(), "Your next donation booking")
            XCTAssertEqual(mainScreenPage.getMainScreenNextBookingViewDCName(), "DC")
            XCTAssertEqual(mainScreenPage.mainScreenNextBookingViewInfoIconExists(), true)
            XCTAssertEqual(mainScreenPage.mainScreenNextBookingViewBookingIconExists(), true)
        }
        
        XCTContext.runActivity(named: "finishing test") { _ in
            mainScreenPage.swipeToGoBack(shouldGoTo: MainViewCasesControllerPage.self)
            XCTAssert(casesPage.isVisible())
        }
    }
    
    private func getBookingIntervalTomorrowAt9() -> String {
        let tomorrow = Calendar.current.date(byAdding: .day, value: 1, to: Date())!
        
        let date = Calendar.current.date(bySettingHour: 9, minute: 0, second: 0, of: tomorrow)!
        
        let formatter = DateFormatter()
        formatter.dateFormat = "HH:mm"
        
        let string = formatter.string(from: date)
        let secondString = formatter.string(from: date.addingTimeInterval(1 * 60 * 20))
        
        let hourPart = "\(string) - \(secondString)"
        
        formatter.dateFormat = "dd-MM-yyyy"
        return "\(formatter.string(from: date)), \(hourPart)"
    }
}
