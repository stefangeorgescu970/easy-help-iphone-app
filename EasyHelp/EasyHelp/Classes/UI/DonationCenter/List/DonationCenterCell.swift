//
//  DonationCenterCell.swift
//  EasyHelp
//
//  Created by Stefan Georgescu on 12/04/2019.
//  Copyright © 2019 EasyHelp. All rights reserved.
//

import UIKit

class DonationCenterCell: UITableViewCell {
    
    private let nameLabel: UILabel = {
        let label = UILabel()
        label.textColor = AppColors.almostBlack
        label.font = AppFonts.boldFontWithSize(18)
        return label
    }()
    
    private let distanceLabel: UILabel = {
        let label = UILabel()
        label.textColor = AppColors.almostBlack
        label.font = AppFonts.regularFontWithSize(14)
        return label
    }()
    
    func syncView(donationCenter: DonationCenter) {
        nameLabel.text = donationCenter.name
        nameLabel.sizeToFit()
        nameLabel.frame = CGRect(x: 20,
                                 y: (frame.height - nameLabel.frame.height) / 2,
                                 width: nameLabel.frame.width,
                                 height: nameLabel.frame.height)
        nameLabel.center.y = frame.height / 2
        addSubview(nameLabel)
        
        if let distance = donationCenter.distance {
            distanceLabel.text = String(format: "%.2f km", distance)
            distanceLabel.sizeToFit()
            distanceLabel.frame.origin = CGPoint(x: frame.width - 20 - distanceLabel.frame.width, y: 0)
            distanceLabel.center.y = nameLabel.center.y
            self.addSubview(distanceLabel)
        }
    }
    
    func showSeparator(_ shouldShow: Bool) {
        if shouldShow {
            AppInterfaceFormatter.addSeparator(view: self, yOffset: self.frame.height - 0.7, marginSpacing: 0, height: 0.7)
        }
    }
}

