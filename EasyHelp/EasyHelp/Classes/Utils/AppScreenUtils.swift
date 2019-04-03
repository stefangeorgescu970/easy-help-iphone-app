//
//  AppScreenUtils.swift
//  EasyHelp
//
//  Created by Stefan Georgescu on 03/04/2019.
//  Copyright © 2019 EasyHelp. All rights reserved.
//

import UIKit

class AppScreenUtils: NSObject {
     static let screenCurrentSafeAreaInsets: UIEdgeInsets = {
        var currentSafeAreaInsets = UIEdgeInsets.zero
        if #available(iOS 11.0, *) {
            if AppScreenUtils.screenVersion >= 7 {
                currentSafeAreaInsets = UIApplication.shared.keyWindow?.safeAreaInsets ?? UIEdgeInsets.zero
            }
        }
        
        return currentSafeAreaInsets
    }()
    
     static let screenStatusBarHeight: CGFloat = {
        let application = UIApplication.shared
        var statusBarHeight = application.statusBarFrame.height
        
        if application.isStatusBarHidden {
            statusBarHeight = 0
        }
        
        return statusBarHeight
    }()
    
    static let screenHeaderHeight: CGFloat = 44
    static let screenStatusBarAndHeaderHeight = screenStatusBarHeight + screenHeaderHeight
    static let screenFooterExtraHeight: CGFloat = screenCurrentSafeAreaInsets.bottom > 0 ? 10.5 : 0
    
     static let screenVersion: Float = {
        let height = UIScreen.main.bounds.height
        if (height < 568) {
            return 4.0
        } else if height < 667 {
            return 5.0
        } else if height < 736 {
            return 6.0
        } else if height < 812 {
            return 6.5;
        } else {
            return 7;
        }
    }()
}

