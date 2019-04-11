//
//  MainScreenViewController.swift
//  EasyHelp
//
//  Created by Stefan Georgescu on 11/04/2019.
//  Copyright © 2019 EasyHelp. All rights reserved.
//

import UIKit

class MainScreenViewController: UIViewController {
    var innerView: MainScreenView
    var profileData: DonorProfileData
    
    init() {
        innerView = MainScreenView(frame: UIScreen.main.bounds)
        profileData = AppServices.profileService.getCurrentUser()!
        
        super.init(nibName: nil, bundle: nil)
        
        self.view = LoadingView(frame: UIScreen.main.bounds, withBgColor: .white)
        innerView.delegate = self
        
        
        AppServices.profileService.getDonationSummary(id: profileData.id) { (data, error) in
            if let data = data {
                self.innerView.syncView(profileData: self.profileData, donorSummary: data)
                self.view = self.innerView
            }
        }
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override func viewDidLoad() {
        self.view = innerView
    }
    
    override func viewWillAppear(_ animated: Bool) {
        self.navigationController?.isNavigationBarHidden = true
    }
}

extension MainScreenViewController: MainScreenViewDelegate {
    func mainScreenViewDidRequestShowWhy(_ sender: MainScreenView) {
        print("why")
    }
    
    func mainScreenViewDidRequestShowHow(_ sender: MainScreenView) {
        print("how")
    }
    
    func mainScreenViewDidRequestBookDonation(_ sender: MainScreenView) {
        print("do booking")
    }
}