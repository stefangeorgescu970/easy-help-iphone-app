//
//  MainFlowManager.swift
//  EasyHelp
//
//  Created by Stefan Georgescu on 22/03/2019.
//  Copyright © 2019 EasyHelp. All rights reserved.
//

import Foundation
import UIKit

class MainFlowManager: NSObject {
    static func redirectAfterLogin() {
        let appDelegate = UIApplication.shared.delegate as! AppDelegate
        let window = appDelegate.window!
        
        let newRootVC: UIViewController = LandingPageViewController()
        
        UIView.transition(with: window, duration: 0.3, options: [.transitionFlipFromLeft, .preferredFramesPerSecond60], animations: {
            window.rootViewController = newRootVC
        })
    }
}
