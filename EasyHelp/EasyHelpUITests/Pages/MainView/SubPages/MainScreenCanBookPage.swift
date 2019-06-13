//
//  MainScreenCanBookPage.swift
//  EasyHelpUITests
//
//  Created by Stefan Georgescu on 13/06/2019.
//  Copyright © 2019 EasyHelp. All rights reserved.
//

import Foundation
import XCTest

protocol MainScreenCanBookPage {
    func mainScreenCanBookViewExists() -> Bool
    func getMainScreenCanBookViewTitle() -> String?
    func getMainScreenCanBookViewSubtitle() -> String?
    func getMainScreenCanBookViewButtonText() -> String?
}

extension MainScreenCanBookPage {
    
    private typealias AccIds = TestStrings.App.MainScreen.CanBook
    
    private var view: XCUIElement { return Page.app.otherElements[AccIds.view] }
    private var titleLabel: XCUIElement { return view.staticTexts[AccIds.title] }
    private var subtitleLabel: XCUIElement { return view.staticTexts[AccIds.subtitle] }
    private var button: XCUIElement { return view.buttons[AccIds.button] }
    
    func mainScreenCanBookViewExists() -> Bool {
        return view.exists
    }
    
    func getMainScreenCanBookViewTitle() -> String? {
        return PageUtils.getStringOptional(fromElement: titleLabel)
    }
    
    func getMainScreenCanBookViewSubtitle() -> String? {
        return PageUtils.getStringOptional(fromElement: subtitleLabel)
    }
    
    func getMainScreenCanBookViewButtonText() -> String? {
        return PageUtils.getStringOptional(fromElement: button)
    }
}
