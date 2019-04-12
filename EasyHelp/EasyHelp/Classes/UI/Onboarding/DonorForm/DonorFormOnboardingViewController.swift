//
//  DonorFormOnboardingViewController.swift
//  EasyHelp
//
//  Created by Stefan Georgescu on 03/04/2019.
//  Copyright © 2019 EasyHelp. All rights reserved.
//

import UIKit

class DonorFormOnboardingViewController: UIViewController {
    private var headerView = AppInterfaceFormatter.createHeader(title: "Donor's Form", subtitle: "In order to speed up your donation booking process, please take 5 minutes to fill in your donation form now.")
    
    private var explainLabel = AppInterfaceFormatter.createLongLabel(text: "You will be asked several questions which you would normally fill in a form at the donation center. Answering them now will mean that you will not have to when you go and donate. You can also skip for now and fill it in later, when booking a donation, or at the donation center.")
    
    private let continueButton: ButtonWithActivity = {
        let button = ButtonWithActivity()
        button.setTitle("Fill in now", for: .normal)
        button.setTitleColor(.white, for: .normal)
        button.backgroundColor = AppColors.appRed
        button.layer.cornerRadius = 8
        
        button.addTarget(self, action: #selector(DonorFormOnboardingViewController.didPressContinue(_:)), for: .touchUpInside)
        
        return button
    }()
    
    private let skipButton = AppInterfaceFormatter.createLink("Skip for now")
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        self.view.backgroundColor = AppColors.white
        
        headerView.frame = CGRect(x: 20, y: 60, width: view.bounds.width - 2 * 20, height: 65)
        
        self.view.addSubview(headerView)
        
        explainLabel.frame = CGRect(x: 20, y: headerView.frame.maxY + 30, width: view.bounds.width - 40, height: 200)
        self.view.addSubview(explainLabel)
        
        continueButton.frame = CGRect(x: 40, y: view.bounds.height - 100, width: view.bounds.width - 80, height: 40)
        self.view.addSubview(continueButton)
        
        skipButton.frame = CGRect(x: (view.bounds.width - skipButton.frame.width) / 2, y: continueButton.frame.minY - skipButton.frame.height - 30, width: skipButton.frame.width, height: skipButton.frame.height)
        skipButton.addTarget(self, action: #selector(DonorFormOnboardingViewController.didPressSkip(_:)), for: .touchUpInside)
        self.view.addSubview(skipButton)
    }
    
    @objc fileprivate func didPressContinue(_ sender: UIButton) {
        
    }
    
    @objc fileprivate func didPressSkip(_ sender: UIButton) {
        MainFlowManager.goToLandingPage()
    }
}
