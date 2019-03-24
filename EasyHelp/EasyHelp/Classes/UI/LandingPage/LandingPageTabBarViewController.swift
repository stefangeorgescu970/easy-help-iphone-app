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
    
    private let dhcNav: UINavigationController
    private let bdcNav: UINavigationController
    private let pdcNav: UINavigationController
    
    private var navControllers: [UINavigationController]!
    
    init() {
        donationHistoryController = DonationHistoryViewController()
        bookDonationController = BookDonationViewController()
        profileDetailsController = ProfileDetailsViewController()
        
        dhcNav = UINavigationController(rootViewController: donationHistoryController)
        bdcNav = UINavigationController(rootViewController: bookDonationController)
        pdcNav = UINavigationController(rootViewController: profileDetailsController)
        
        dhcNav.tabBarItem = UITabBarItem(title: "History", image: nil, tag: 0)
        bdcNav.tabBarItem = UITabBarItem(title: "Book", image: nil, tag: 1)
        pdcNav.tabBarItem = UITabBarItem(title: "Profile", image: nil, tag: 2)
        
        super.init(nibName: nil, bundle: nil)
        
        let viewControllers = [dhcNav, bdcNav, pdcNav]
        
        self.viewControllers = viewControllers
        
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
