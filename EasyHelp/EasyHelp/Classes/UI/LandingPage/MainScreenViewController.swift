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
                self.viewDidLoad()
            }
        }
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override func viewDidLoad() {
        self.view = UIView(frame: UIScreen.main.bounds)
        
        #if MOCK
        innerView.frame.origin.y = AppScreenUtils.screenStatusBarAndHeaderHeight
        #endif
        
        self.view.addSubview(innerView)
    }
    
    override func viewWillAppear(_ animated: Bool) {
        #if MOCK
        self.navigationController?.isNavigationBarHidden = false
        #else
        self.navigationController?.isNavigationBarHidden = true
        #endif
    }
    
    func syncView(forBooking booking: DonationBooking?) {
        self.innerView.syncView(forBooking: booking)
    }
}

extension MainScreenViewController: MainScreenViewDelegate {
    func mainScreenViewDidRequestShowRecentDonation(_ sender: MainScreenView, donation: Donation) {
        let navController = UINavigationController(rootViewController: DonationDetailsViewController(donation: donation))
        self.navigationController?.present(navController, animated: true, completion: nil)
    }
    
    func mainScreenViewDidRequestShowDonation(_ sender: MainScreenView, donationBooking: DonationBooking) {
        let navController = UINavigationController(rootViewController: DonationBookingViewController(donationBooking: donationBooking, style: .view))
        self.navigationController?.present(navController, animated: true, completion: nil)
    }
    
    func mainScreenViewDidRequestShowWhy(_ sender: MainScreenView) {
        print("why")
    }
    
    func mainScreenViewDidRequestShowHow(_ sender: MainScreenView) {
        print("how")
    }
    
    func mainScreenViewDidRequestBookDonation(_ sender: MainScreenView) {
        let navController = UINavigationController(rootViewController: DonationCentersViewController())
        self.navigationController?.present(navController, animated: true, completion: nil)
    }
}
