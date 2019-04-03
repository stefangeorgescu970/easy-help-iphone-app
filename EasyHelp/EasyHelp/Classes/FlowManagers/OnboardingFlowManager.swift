//
//  OnboardingFlowManager.swift
//  EasyHelp
//
//  Created by Stefan Georgescu on 03/04/2019.
//  Copyright © 2019 EasyHelp. All rights reserved.
//

import UIKit

class OnboardingFlowManager: NSObject {
    
    static let instance = OnboardingFlowManager()
    
    var hasFinishedFlow = false
    
    
    func startFlow() {
        let appDelegate = UIApplication.shared.delegate as! AppDelegate
        let window = appDelegate.window!
        
        let newRootVC: UIViewController = CountySSNOnboardingViewController()
        let navVc = UINavigationController(rootViewController: newRootVC)
        
        UIView.transition(with: window, duration: 0.3, options: [.transitionFlipFromLeft, .preferredFramesPerSecond60], animations: {
            window.rootViewController = navVc
        })
    }
    
}
