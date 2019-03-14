//
//  AppFonts.swift
//  EasyHelp
//
//  Created by Stefan Georgescu on 14/03/2019.
//  Copyright © 2019 EasyHelp. All rights reserved.
//

import UIKit

enum AppFontFamily: String {
    case SourceSansPro = "SourceSansPro"
}

enum AppFontStyle: String {
    case Light = "Light"
    case Regular = "Regular"
    case SemiBold = "SemiBold"
    case Bold = "Bold"
}

class AppFonts {
    private class func fontWithSize(_ size: CGFloat, font: AppFontFamily, style: AppFontStyle) -> UIFont {
        return UIFont(name: "\(font.rawValue)-\(style.rawValue)", size: size)!
    }
    
    class func lightFontWithSize(_ size: CGFloat) -> UIFont {
        return UIFont.systemFont(ofSize: size, weight: .light)
    }
    
    class func regularFontWithSize(_ size: CGFloat) -> UIFont {
        return UIFont.systemFont(ofSize: size, weight: .regular)
    }
    
    class func semiBoldFontWithSize(_ size: CGFloat) -> UIFont {
        return UIFont.systemFont(ofSize: size, weight: .semibold)
    }
    
    class func boldFontWithSize(_ size: CGFloat) -> UIFont {
        return UIFont.systemFont(ofSize: size, weight: .bold)
    }
}

