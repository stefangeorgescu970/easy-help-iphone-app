//
//  MainScreenNextBookingPage.swift
//  EasyHelpUITests
//
//  Created by Stefan Georgescu on 13/06/2019.
//  Copyright © 2019 EasyHelp. All rights reserved.
//

import Foundation
import XCTest

protocol MainScreenNextBookingPage {
    func mainScreenNextBookingViewExists() -> Bool
    func mainScreenNextBookingViewBookingIconExists() -> Bool
    func mainScreenNextBookingViewInfoIconExists() -> Bool
    func getMainScreenNextBookingViewTitle() -> String?
    func getMainScreenNextBookingViewDate() -> String?
    func getMainScreenNextBookingViewDCName() -> String?
}

extension MainScreenNextBookingPage {
    
    private typealias AccIds = TestStrings.App.MainScreen.NextBooking
    
    private var view: XCUIElement { return Page.app.otherElements[AccIds.view] }
    private var titleLabel: XCUIElement { return view.staticTexts[AccIds.title] }
    private var nameLabel: XCUIElement { return view.staticTexts[AccIds.nameLabel] }
    private var dateLabel: XCUIElement { return view.staticTexts[AccIds.dateLabel] }
    private var bookingIcon: XCUIElement { return view.images[AccIds.bookingIcon] }
    private var infoIcon: XCUIElement { return view.images[AccIds.infoIcon] }
    
    func mainScreenNextBookingViewExists() -> Bool {
        return view.exists
    }
    
    func mainScreenNextBookingViewBookingIconExists() -> Bool {
        return bookingIcon.exists
    }
    
    func mainScreenNextBookingViewInfoIconExists() -> Bool {
        return infoIcon.exists
    }
    
    func getMainScreenNextBookingViewTitle() -> String? {
        return PageUtils.getStringOptional(fromElement: titleLabel)
    }
    
    func getMainScreenNextBookingViewDate() -> String? {
        return PageUtils.getStringOptional(fromElement: dateLabel)
    }
    
    func getMainScreenNextBookingViewDCName() -> String? {
        return PageUtils.getStringOptional(fromElement: nameLabel)
    }
}
