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
        
        super.init(nibName: nil, bundle: nil)
        
        addTabBarItems()
        
        let viewControllers = [dhcNav, bdcNav, pdcNav]
        
        self.viewControllers = viewControllers
        
        self.selectedIndex = 1
        
        self.tabBar.tintColor = .red
        self.view.backgroundColor = .white
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override func viewDidLoad() {
        self.edgesForExtendedLayout = []
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(true)
        
        self.addRaisedButton(UIImage(named: "blood_drop_tab_bar"), highlightImage: nil, offset: -10)
    }
    
    private func addTabBarItems() {
        let dhcIcon = UIImage(named: "history_icon")?.resize(to: CGSize(width: 35, height: 30))
        let dhcTabBarItem = UITabBarItem(title: "History", image: dhcIcon, tag: 0)
        dhcTabBarItem.titlePositionAdjustment = UIOffset(horizontal: 15, vertical: 0)
        dhcNav.tabBarItem = dhcTabBarItem
        
        bdcNav.tabBarItem = UITabBarItem(title: nil, image: nil, tag: 1)
        
        let pdcIcon = UIImage(named: "profile_icon")?.resize(to: CGSize(width: 35, height: 35))
        let pdcNavTabBarItem = UITabBarItem(title: "Profile", image: pdcIcon, tag: 2)
        pdcNavTabBarItem.titlePositionAdjustment = UIOffset(horizontal: -15, vertical: 0)
        pdcNav.tabBarItem = pdcNavTabBarItem
    }
    
    private func addRaisedButton(_ buttonImage: UIImage?, highlightImage: UIImage?, offset:CGFloat? = nil) {
        if let buttonImage = buttonImage {
            let button = UIButton(type: UIButton.ButtonType.custom)
            button.autoresizingMask = [.flexibleRightMargin, .flexibleLeftMargin, .flexibleBottomMargin, .flexibleTopMargin]
            
            button.frame = CGRect(x: 0.0, y: 0.0, width: buttonImage.size.width / 1.5, height: buttonImage.size.height / 1.5)
            button.setBackgroundImage(buttonImage, for: .normal)
            button.setBackgroundImage(highlightImage, for: .highlighted)
            
            button.addTarget(self, action: #selector(LandingPageTabBarViewController.onRaisedButton(_:)), for: .touchUpInside)
            
            let heightDifference = buttonImage.size.height - self.tabBar.frame.size.height
            
            if (heightDifference < 0) {
                button.center = self.tabBar.center
            } else {
                var center = self.tabBar.center
                center.y -= heightDifference / 2.0
                
                button.center = center
            }
            
            if offset != nil {
                //Add offset
                var center = button.center
                center.y = center.y + offset!
                button.center = center
            }
            
            self.view.addSubview(button)
        }
    }
    
    @objc private func onRaisedButton(_ sender: UIButton) {
        self.selectedViewController = bdcNav
    }
}
