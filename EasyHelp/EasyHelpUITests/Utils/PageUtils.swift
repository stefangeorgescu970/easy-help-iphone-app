//
//  PageUtils.swift
//  EasyHelpUITests
//
//  Created by Stefan Georgescu on 13/06/2019.
//  Copyright © 2019 EasyHelp. All rights reserved.
//

import Foundation
import XCTest

class PageUtils {
    
    // MARK: - Access page elements
    
    static func getStringOptional(fromElement: XCUIElement, extraCondition: @autoclosure () -> Bool = true) -> String? {
        if fromElement.exists && extraCondition() {
            return fromElement.label.replacingOccurrences(of: "\n", with: " ").replacingOccurrences(of: "\r", with: "")
        }
        return nil
    }
    
    static func getStringOptional(fromRootElement: XCUIElement, staticTextIndex: Int) -> String? {
        return PageUtils.getStringOptional(fromElement: fromRootElement.staticTexts.element(boundBy: staticTextIndex))
    }
    
    static func getStringOptionalFromValue(fromElement: XCUIElement) -> String? {
        if fromElement.exists {
            if fromElement.value as? String == fromElement.placeholderValue {
                return nil
            }
            return fromElement.value as? String
        }
        return nil
    }
    
    static func getStringOptional(fromRootElement: XCUIElement, matching: String) -> String? {
        if fromRootElement.exists {
            let staticText = fromRootElement.staticTexts[matching]
            return PageUtils.getStringOptional(fromElement: staticText)
        }
        return nil
    }
}
