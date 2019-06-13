//
//  MainScreenRecentDonationPage.swift
//  EasyHelpUITests
//
//  Created by Stefan Georgescu on 13/06/2019.
//  Copyright © 2019 EasyHelp. All rights reserved.
//

import Foundation
import XCTest

protocol MainScreenRecentDonationPage {
    func mainScreenRecentDonationViewExists() -> Bool
    func getMainScreenRecentDonationViewTitle() -> String?
    func getMainScreenRecentDonationViewButtonText() -> String?
}

extension MainScreenRecentDonationPage {
    
    private typealias AccIds = TestStrings.App.MainScreen.RecentDonation
    
    private var view: XCUIElement { return Page.app.otherElements[AccIds.view] }
    private var titleLabel: XCUIElement { return view.staticTexts[AccIds.title] }
    private var button: XCUIElement { return view.buttons[AccIds.button] }
    
    func mainScreenRecentDonationViewExists() -> Bool {
        return view.exists
    }
    
    func getMainScreenRecentDonationViewTitle() -> String? {
        return PageUtils.getStringOptional(fromElement: titleLabel)
    }
    
    func getMainScreenRecentDonationViewButtonText() -> String? {
        return PageUtils.getStringOptional(fromElement: button)
    }
}
