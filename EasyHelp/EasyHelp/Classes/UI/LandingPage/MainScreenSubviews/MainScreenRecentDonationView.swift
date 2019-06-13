//
//  MainScreenRecentDonationView.swift
//  EasyHelp
//
//  Created by Stefan Georgescu on 23/05/2019.
//  Copyright © 2019 EasyHelp. All rights reserved.
//

import UIKit

protocol MainScreenRecentDonationViewDelegate: class {
    func mainScreenRecentDonationView(_ view: MainScreenRecentDonationView, didRequestViewDonation donation: Donation)
}

class MainScreenRecentDonationView: UIView {
    
    private typealias AccIds = TestStrings.App.MainScreen.RecentDonation
    
    weak var delgate: MainScreenRecentDonationViewDelegate?
    
    var donation: Donation
    
    private let titleLabel: UILabel = {
        let label = UILabel(frame: CGRect.zero)
        label.textColor = AppColors.almostBlack
        label.font = AppFonts.boldFontWithSize(16)
        label.contentMode = .center
        label.textAlignment = .center
        label.accessibilityIdentifier = AccIds.title
        
        return label
    }()
    
    private let viewBookingButton = AppInterfaceFormatter.createLink("View Last Donation")
    
    init(frame: CGRect, donation: Donation, daysUntilCanDonate: Int) {
        self.donation = donation
        
        super.init(frame: frame)
        accessibilityIdentifier = AccIds.view
        
        viewBookingButton.frame.origin = CGPoint(x: (frame.width - viewBookingButton.frame.width) / 2,
                                                 y: frame.height - viewBookingButton.frame.height - 20 - 60)
        viewBookingButton.addTarget(self, action: #selector(MainScreenRecentDonationView.didTapViewBooking(_:)), for: .touchUpInside)
        viewBookingButton.accessibilityIdentifier = AccIds.button
        self.addSubview(viewBookingButton)
        
        titleLabel.text = "You will be able to donate again in \(daysUntilCanDonate) days."
        titleLabel.sizeToFit()
        titleLabel.frame.origin = CGPoint(x: (frame.width - titleLabel.frame.width) / 2,
                                          y: viewBookingButton.frame.origin.y - titleLabel.frame.height - 10)
        self.addSubview(titleLabel)
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    @objc fileprivate func didTapViewBooking(_ sender: UIButton) {
        self.delgate?.mainScreenRecentDonationView(self, didRequestViewDonation: donation)
    }
}
