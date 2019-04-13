//
//  DonationCenterInfoView.swift
//  EasyHelp
//
//  Created by Stefan Georgescu on 13/04/2019.
//  Copyright © 2019 EasyHelp. All rights reserved.
//

import UIKit

protocol DonationCenterInfoViewDelegate: class {
    func donationCenterInfoViewDidRequestViewMap(_ sender: DonationCenterInfoView, forDonationCenter donationCenter: DonationCenter)
    func donationCenterInfoViewDidTapDate(_ sender: DonationCenterInfoView, withIndex index: Int)
}

class DonationCenterInfoView: UIView {
    
    weak var delegate: DonationCenterInfoViewDelegate?
    var donationCenter: DonationCenter
    
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
    
    private let scrollView: UIScrollView
    private let addressLink: UIButton
    private var dayButtons: [UIButton] = []
    private var selectedDateIndex = -1
    
    init(frame: CGRect, donationCenter: DonationCenter) {
        self.donationCenter = donationCenter
        self.addressLink = AppInterfaceFormatter.createLink(donationCenter.address)
        self.scrollView = UIScrollView(frame: CGRect(x: 0, y: frame.height - 60, width: frame.width, height: 60))
        super.init(frame: frame)
        self.backgroundColor = AppColors.white
        
        hospitalIcon.frame.origin = CGPoint(x: 20, y: 20)
        self.addSubview(hospitalIcon)
        
        nameLabel.text = donationCenter.name
        nameLabel.sizeToFit()
        nameLabel.frame.origin = CGPoint(x: hospitalIcon.frame.maxX + 10, y: 20)
        self.addSubview(nameLabel)
        
        countyLabel.text = donationCenter.county
        countyLabel.sizeToFit()
        countyLabel.frame.origin = CGPoint(x: hospitalIcon.frame.maxX + 10, y: hospitalIcon.frame.maxY - countyLabel.frame.height - 4)
        self.addSubview(countyLabel)
        
        self.addressLink.frame.origin = CGPoint(x: (frame.width - addressLink.frame.width) / 2, y: countyLabel.frame.maxY + 10)
        self.addressLink.addTarget(self, action: #selector(DonationCenterInfoView.didPressAddress(_:)), for: .touchUpInside)
        self.addSubview(addressLink)
        
        scrollView.showsVerticalScrollIndicator = false
        scrollView.translatesAutoresizingMaskIntoConstraints = false
        scrollView.showsHorizontalScrollIndicator = false
        self.addSubview(scrollView)
        
        let buttonWidth: CGFloat = 70
        let buttonHeight: CGFloat = 40
        var currentX: CGFloat = 20
        
        for index in 0..<7 {
            let button = UIButton(frame: CGRect(x: currentX, y: 10, width: buttonWidth, height: buttonHeight))
            button.tag = index
            button.setTitleColor(AppColors.white, for: .normal)
            button.backgroundColor = AppColors.darkGray
            button.layer.cornerRadius = 10
            currentX += buttonWidth + 15
            button.addTarget(self, action: #selector(DonationCenterInfoView.didTapDateButton(_:)), for: .touchUpInside)
            button.alpha = 0
            scrollView.addSubview(button)
            dayButtons.append(button)
        }
        
        scrollView.contentSize = CGSize(width: currentX, height: 60)
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    func syncView(forAvailableDates availableDates: [AvailableDate]) {
        var notSelected = true
        
        for (index, button) in self.dayButtons.enumerated() {
            let date = availableDates[index].date
            if availableDates[index].availableHours.count == 0 {
                button.backgroundColor = AppColors.lightGray
                button.isUserInteractionEnabled = false
            } else if notSelected {
                self.didTapDateButton(button)
                notSelected = !notSelected
            }
            let dateFormatter = DateFormatter()
            dateFormatter.dateFormat = "dd-MM"
            button.setTitle(dateFormatter.string(from: date), for: .normal)
        }
        
        UIView.animate(withDuration: 0.5, animations: {
            for button in self.dayButtons {
                button.alpha = 1
            }
        }) { (didComplete) in
            
        }
    }
    
    @objc fileprivate func didPressAddress(_ sender: UIButton) {
        self.delegate?.donationCenterInfoViewDidRequestViewMap(self, forDonationCenter: donationCenter)
    }
    
    @objc fileprivate func didTapDateButton(_ sender: UIButton) {
        if self.selectedDateIndex != -1 {
            self.dayButtons[self.selectedDateIndex].backgroundColor = AppColors.darkGray
        }
        
        self.selectedDateIndex = sender.tag
        sender.backgroundColor = AppColors.appRed
        self.delegate?.donationCenterInfoViewDidTapDate(self, withIndex: self.selectedDateIndex)
    }
}
