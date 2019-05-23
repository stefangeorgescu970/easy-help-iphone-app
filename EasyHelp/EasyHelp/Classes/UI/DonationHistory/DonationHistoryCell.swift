//
//  DonationHistoryCell.swift
//  EasyHelp
//
//  Created by Stefan Georgescu on 23/05/2019.
//  Copyright © 2019 EasyHelp. All rights reserved.
//

import UIKit

class DonationHistoryCell: UITableViewCell {
    
    private let dateFormatter: DateFormatter = {
        let formatter = DateFormatter()
        formatter.dateFormat = "E, d MMM yyyy"
        return formatter
    }()
    
    private let nameLabel: UILabel = {
        let label = UILabel()
        label.textColor = AppColors.almostBlack
        label.font = AppFonts.boldFontWithSize(18)
        return label
    }()
    
    private let dateLabel: UILabel = {
        let label = UILabel()
        label.textColor = AppColors.almostBlack
        label.font = AppFonts.regularFontWithSize(16)
        return label
    }()
    
    private let infoIcon: UIImageView = {
        let image = UIImage(named: "ic_info")
        let imageView = UIImageView(image: image?.resize(to: CGSize(width: 30, height: 30)))
        return imageView
    }()
    
    func syncView(donation: Donation) {
        let roundedRect = UIBezierPath(roundedRect: CGRect(x: 10, y: 15, width: self.frame.width - 20, height: self.frame.height - 30),
                                       cornerRadius: 10)
        
        let shapeLayer = CAShapeLayer()
        shapeLayer.fillColor = UIColor(red: 240/255, green: 240/255, blue: 240/255, alpha: 0.3).cgColor
        shapeLayer.path = roundedRect.cgPath
        shapeLayer.strokeColor = AppColors.darkGray.cgColor
        shapeLayer.lineWidth = 1.0
        
        self.layer.addSublayer(shapeLayer)
        
        nameLabel.text = donation.donationCenter.name
        nameLabel.sizeToFit()
        nameLabel.frame = CGRect(x: 20,
                                 y: (frame.height - nameLabel.frame.height) / 3,
                                 width: nameLabel.frame.width,
                                 height: nameLabel.frame.height)
        
        dateLabel.text = dateFormatter.string(from: donation.date)
        dateLabel.sizeToFit()
        dateLabel.frame = CGRect(x: 20,
                                 y: (frame.height - dateLabel.frame.height) / 3 * 2,
                                 width: dateLabel.frame.width,
                                 height: dateLabel.frame.height)
        
        infoIcon.frame.origin = CGPoint(x: frame.width - 30 - infoIcon.frame.width, y: (frame.height - infoIcon.frame.height) / 2)
        
        addSubview(dateLabel)
        addSubview(nameLabel)
        addSubview(infoIcon)
        
        self.selectionStyle = .none
    }
    
    func showSeparator(_ shouldShow: Bool) {
        if shouldShow {
            AppInterfaceFormatter.addSeparator(view: self, yOffset: self.frame.height - 0.7, marginSpacing: 0, height: 0.7)
        }
    }
}

