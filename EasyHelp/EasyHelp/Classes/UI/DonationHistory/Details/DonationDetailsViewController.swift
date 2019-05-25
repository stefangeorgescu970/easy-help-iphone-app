//
//  DonationDetailsViewController.swift
//  EasyHelp
//
//  Created by Stefan Georgescu on 23/05/2019.
//  Copyright © 2019 EasyHelp. All rights reserved.
//

import UIKit

class DonationDetailsViewController: UIViewController {
    
    var donationDetailsView: DonationDetailsView
    
    init(donation: Donation) {
        donationDetailsView = DonationDetailsView(donation: donation, frame: UIScreen.main.bounds)
        super.init(nibName: nil, bundle: nil)
        
        self.title = "Donation Details"
        
        let closeBtn = AppInterfaceFormatter.navigationBarButtonWithIcon(UIImage(named: "close_icon")!, highlightIcon: nil)
        closeBtn.addTarget(self, action: #selector(DonationDetailsViewController.onClose(_:)), for: UIControl.Event.touchUpInside)
        self.navigationItem.rightBarButtonItem = UIBarButtonItem(customView: closeBtn)
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override func viewDidLoad() {
        self.edgesForExtendedLayout = []
        self.view = donationDetailsView
    }
    
    @objc func onClose(_ sender: UIButton) {
        self.navigationController?.dismiss(animated: true, completion: nil)
    }
}
