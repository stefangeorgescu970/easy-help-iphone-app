//
//  MainScreenTooManyDonationsPage.swift
//  EasyHelpUITests
//
//  Created by Stefan Georgescu on 13/06/2019.
//  Copyright © 2019 EasyHelp. All rights reserved.
//

import XCTest

protocol MainScreenTooManyDonationsPage {
    func mainScreenTooManyDonationsViewExists() -> Bool
    func getMainScreenTooManyDonationsViewTitle() -> String?
    func getMainScreenTooManyDonationsViewSubtitle() -> String?
}

extension MainScreenTooManyDonationsPage {
    
    private typealias AccIds = TestStrings.App.MainScreen.TooManyDonations
    
    private var view: XCUIElement { return Page.app.otherElements[AccIds.view] }
    private var titleLabel: XCUIElement { return view.staticTexts[AccIds.title] }
    private var subtitleLabel: XCUIElement { return view.staticTexts[AccIds.subtitle] }
    
    func mainScreenTooManyDonationsViewExists() -> Bool {
        return view.exists
    }
    
    func getMainScreenTooManyDonationsViewTitle() -> String? {
        return PageUtils.getStringOptional(fromElement: titleLabel)
    }
    
    func getMainScreenTooManyDonationsViewSubtitle() -> String? {
        return PageUtils.getStringOptional(fromElement: subtitleLabel)
    }
}
