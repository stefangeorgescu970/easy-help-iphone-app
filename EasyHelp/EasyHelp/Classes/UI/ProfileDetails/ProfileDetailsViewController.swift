//
//  ProfileDetailsViewController.swift
//  EasyHelp
//
//  Created by Stefan Georgescu on 22/03/2019.
//  Copyright © 2019 EasyHelp. All rights reserved.
//

import UIKit

class ProfileDetailsViewController: UIViewController {
    
    var innerView: ProfileDetailsView
    
    init() {
        innerView = ProfileDetailsView(frame: UIScreen.main.bounds, profileData: AppServices.profileService.getCurrentUser()!)
        super.init(nibName: nil, bundle: nil)
        innerView.delegate = self
        
        self.title = "Profile Details"
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        self.view = innerView
    }
}

extension ProfileDetailsViewController: ProfileDetailsViewDelegate {
    func profileDetailsViewDidRequestTermsAndConditions(_ sender: ProfileDetailsView) {
        
    }
    
    func profileDetailsViewDidRequestFAQ(_ sender: ProfileDetailsView) {
        
    }
    
    func profileDetailsViewDidRequestLogout(_ sender: ProfileDetailsView) {
        print("logout")
    }
}
