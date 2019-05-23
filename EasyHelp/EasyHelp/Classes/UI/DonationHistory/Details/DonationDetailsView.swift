//
//  DonationDetailsView.swift
//  EasyHelp
//
//  Created by Stefan Georgescu on 23/05/2019.
//  Copyright © 2019 EasyHelp. All rights reserved.
//

import UIKit

class DonationDetailsView: UIScrollView {
    
    private let dateFormatter: DateFormatter = {
        let formatter = DateFormatter()
        formatter.dateFormat = "E, d MMM yyyy"
        return formatter
    }()
    
    private let titleLabel: UILabel = {
        let label = UILabel()
        label.textColor = AppColors.appRed
        label.font = AppFonts.boldFontWithSize(24)
        label.text = "Blood Donation"
        label.sizeToFit()
        return label
    }()
    
    private let subtitleLabel: UILabel = {
        let label = UILabel()
        label.textColor = AppColors.almostBlack
        label.font = AppFonts.regularFontWithSize(16)
        return label
    }()
    
    private let hospitalIcon: UIImageView = {
        let image = UIImage(named: "hospital")
        let imageView = UIImageView(image: image?.resize(to: CGSize(width: 60, height: 60)))
        return imageView
    }()
    
    private let nameLabel: UILabel = {
        let label = UILabel()
        label.textColor = AppColors.almostBlack
        label.font = AppFonts.boldFontWithSize(18)
        return label
    }()
    
    private let countyLabel: UILabel = {
        let label = UILabel()
        label.textColor = AppColors.almostBlack
        label.font = AppFonts.regularFontWithSize(16)
        return label
    }()
    
    private let addressLink: UIButton
    
    private let resultsTitleLabel: UILabel = {
        let label = UILabel()
        label.textColor = AppColors.appRed
        label.font = AppFonts.boldFontWithSize(20)
        label.text = "Test Results"
        label.sizeToFit()
        return label
    }()
    
    private let noResultsLabel: UILabel = {
        let label = UILabel()
        label.textColor = AppColors.almostBlack
        label.font = AppFonts.regularFontWithSize(16)
        label.text = "Test results for this donation are not yet available."
        label.sizeToFit()
        return label
    }()
    
    
    init(donation: Donation, frame: CGRect) {
        self.addressLink = AppInterfaceFormatter.createLink(donation.donationCenter.address)
        super.init(frame: frame)
        
        self.backgroundColor = AppColors.white
        
        titleLabel.frame.origin = CGPoint(x: (frame.width - titleLabel.frame.width) / 2, y: 20)
        self.addSubview(titleLabel)
        
        subtitleLabel.text = "from \(dateFormatter.string(from: donation.date))"
        subtitleLabel.sizeToFit()
        subtitleLabel.frame.origin = CGPoint(x: (frame.width - subtitleLabel.frame.width) / 2, y: titleLabel.frame.maxY + 10)
        self.addSubview(subtitleLabel)
        
        hospitalIcon.frame.origin = CGPoint(x: 20, y: subtitleLabel.frame.maxY + 20)
        self.addSubview(hospitalIcon)
        
        nameLabel.text = donation.donationCenter.name
        nameLabel.sizeToFit()
        nameLabel.frame.origin = CGPoint(x: hospitalIcon.frame.maxX + 10, y: subtitleLabel.frame.maxY + 20)
        self.addSubview(nameLabel)
        
        countyLabel.text = donation.donationCenter.county
        countyLabel.sizeToFit()
        countyLabel.frame.origin = CGPoint(x: hospitalIcon.frame.maxX + 10, y: hospitalIcon.frame.maxY - countyLabel.frame.height - 4)
        self.addSubview(countyLabel)
        
        self.addressLink.frame.origin = CGPoint(x: (frame.width - addressLink.frame.width) / 2, y: countyLabel.frame.maxY + 10)
        self.addressLink.addTarget(self, action: #selector(DonationDetailsView.didPressAddress(_:)), for: .touchUpInside)
        self.addSubview(addressLink)
        
        resultsTitleLabel.frame.origin = CGPoint(x: 20, y: addressLink.frame.maxY + 20)
        self.addSubview(resultsTitleLabel)
        
        var currentY = resultsTitleLabel.frame.maxY + 10
        
        if let testResults = donation.testResults {
            var hadProblems = false
            
            for (left, right) in testResults.buildTestedDisease() {
                let isProblem = right == "Positive"
                hadProblems = hadProblems || isProblem
                let rowHeight = AppInterfaceFormatter.addDefaultInfoRow(toView: self,
                                                                        leftText: left,
                                                                        rightText: right,
                                                                        marginSpacing: 20,
                                                                        yOffset: currentY,
                                                                        isAlert: isProblem)
                currentY += rowHeight + 10
                AppInterfaceFormatter.addSeparator(view: self, yOffset: currentY, marginSpacing: 20, height: 0.5)
                currentY += 15 + 1
            }
            if hadProblems {
                let label = AppInterfaceFormatter.createLongLabel(text: "It is recommended that you get in touch with your doctor as soon as possible.")
                label.frame = CGRect(x: 20, y: currentY, width: self.bounds.width - 40, height: 75)
                self.addSubview(label)
                currentY += 75
            }
            
        } else {
            noResultsLabel.frame.origin = CGPoint(x: 20, y: currentY)
            currentY += noResultsLabel.frame.height + 10
            self.addSubview(noResultsLabel)
        }
        
        self.contentSize = CGSize(width: frame.width, height: currentY)
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    @objc private func didPressAddress(_ sender: UIButton) {
        
    }
    
}
