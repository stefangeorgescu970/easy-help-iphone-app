//
//  LandingPageTabBarViewController.swift
//  EasyHelp
//
//  Created by Stefan Georgescu on 14/03/2019.
//  Copyright © 2019 EasyHelp. All rights reserved.
//

import UIKit

class LandingPageTabBarViewController: UITabBarController {
    private let donationHistoryController: DonationHistoryViewController
    private let bookDonationController: BookDonationViewController
    private let profileDetailsController: ProfileDetailsViewController
    
    init() {
        donationHistoryController = DonationHistoryViewController()
        bookDonationController = BookDonationViewController()
        profileDetailsController = ProfileDetailsViewController()
        
        donationHistoryController.tabBarItem = UITabBarItem(title: "History", image: nil, tag: 0)
        bookDonationController.tabBarItem = UITabBarItem(title: "Book", image: nil, tag: 1)
        profileDetailsController.tabBarItem = UITabBarItem(title: "Profile", image: nil, tag: 2)
        
        super.init(nibName: nil, bundle: nil)
        
        self.viewControllers = [donationHistoryController, bookDonationController, profileDetailsController]
        
        self.tabBar.tintColor = .red
        self.view.backgroundColor = .white
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override func viewDidLoad() {
        self.edgesForExtendedLayout = []
    }
}
