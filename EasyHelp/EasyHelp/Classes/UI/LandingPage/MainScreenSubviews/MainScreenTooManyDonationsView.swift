//
//  MainScreenTooManyDonationsView.swift
//  EasyHelp
//
//  Created by Stefan Georgescu on 31/05/2019.
//  Copyright © 2019 EasyHelp. All rights reserved.
//

import UIKit

class MainScreenTooManyDonationsView: UIView {
    
    private typealias AccIds = TestStrings.App.MainScreen.TooManyDonations
    
    private let titleLabel: UILabel = {
        let label = UILabel(frame: CGRect.zero)
        label.textColor = AppColors.almostBlack
        label.font = AppFonts.boldFontWithSize(16)
        label.contentMode = .center
        label.textAlignment = .center
        label.accessibilityIdentifier = AccIds.title
        
        return label
    }()
    
    private let subtitleLabel: UILabel = {
        let label = UILabel(frame: CGRect.zero)
        label.textColor = AppColors.almostBlack
        label.font = AppFonts.regularFontWithSize(14)
        label.contentMode = .center
        label.textAlignment = .center
        label.accessibilityIdentifier = AccIds.subtitle
        
        return label
    }()
    
    init(frame: CGRect, beginDate: Date) {
        super.init(frame: frame)
        accessibilityIdentifier = AccIds.view
        
        let profileData = AppServices.profileService.getCurrentUser()!
        let maxDonations = profileData.isMale ? 5 : 4
        
        titleLabel.text = "You are not eligible for donating now"
        titleLabel.sizeToFit()
        titleLabel.frame.origin = CGPoint(x: (frame.width - titleLabel.frame.width) / 2, y: 20)
        
        subtitleLabel.text = "You have already donated \(maxDonations) times this year.\nYou will be able to donate again in \(DateUtils.getDaysUntilOneYear(fromDate: beginDate)) days"
        subtitleLabel.numberOfLines = 0
        subtitleLabel.sizeToFit()
        subtitleLabel.frame.origin = CGPoint(x: (frame.width - subtitleLabel.frame.width) / 2, y: titleLabel.frame.maxY + 10)
    
        self.addSubview(titleLabel)
        self.addSubview(subtitleLabel)
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}
