//
//  DonationBookingView.swift
//  EasyHelp
//
//  Created by Stefan Georgescu on 25/05/2019.
//  Copyright © 2019 EasyHelp. All rights reserved.
//

import UIKit

protocol DonationBookingViewDelegate: class {
    func donationBookingViewDidRequestForm(_ sender: DonationBookingView)
    func donationBookingViewDidRequestBook(_ sender: DonationBookingView, donationBooking: DonationBooking)
    func donationBookingViewDidRequestCancelBooking(_ sender: DonationBookingView, donationBooking: DonationBooking)
}

class DonationBookingView: UIView {
    
    weak var delegate: DonationBookingViewDelegate?
    var donationBooking: DonationBooking
    var style: DonationBookingControllerStyle
    
    private let titleLabel: UILabel = {
        let label = UILabel()
        label.textColor = AppColors.appRed
        label.font = AppFonts.boldFontWithSize(24)
        label.text = "Donation Center"
        label.sizeToFit()
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
    
    private let bookingTitle: UILabel = {
        let label = UILabel()
        label.textColor = AppColors.appRed
        label.font = AppFonts.boldFontWithSize(24)
        label.text = "Booking Information"
        label.sizeToFit()
        return label
    }()
    
    private let dateLabel: UILabel = {
        let label = UILabel()
        label.textColor = AppColors.almostBlack
        label.font = AppFonts.regularFontWithSize(16)
        return label
    }()
    
    private let hourLabel: UILabel = {
        let label = UILabel()
        label.textColor = AppColors.almostBlack
        label.font = AppFonts.regularFontWithSize(16)
        return label
    }()
    
    private let donationFormTitle: UILabel = {
        let label = UILabel()
        label.textColor = AppColors.appRed
        label.font = AppFonts.boldFontWithSize(24)
        label.text = "Donation Form"
        label.sizeToFit()
        return label
    }()
    
    private let donationFormSubtitle: UILabel = {
        let label = UILabel()
        label.textColor = AppColors.darkGray
        label.font = AppFonts.regularFontWithSize(14)
        label.text = "Please review donation form before booking request"
        label.sizeToFit()
        return label
    }()
    
    private let formImageView: UIImageView = {
        let image = UIImage(named: "profile_file")
        let imageView = UIImageView(image: image?.resize(to: CGSize(width: 40, height: 40)))
        return imageView
    }()
    
    private var formActionButton: UIButton = AppInterfaceFormatter.createLink("Fill in donation form")
    
    private let actionButton: ButtonWithActivity = {
        let button = ButtonWithActivity()
        button.setTitleColor(.white, for: .normal)
        button.backgroundColor = AppColors.appRed
        button.layer.cornerRadius = 8
        
        button.addTarget(self, action: #selector(DonationBookingView.didPressMainActionBook(_:)), for: .touchUpInside)
        
        return button
    }()
    
    init(frame: CGRect, donationBooking: DonationBooking, style: DonationBookingControllerStyle) {
        self.donationBooking = donationBooking
        self.addressLink = AppInterfaceFormatter.createLink(donationBooking.donationCenter.address)
        self.style = style
        super.init(frame: frame)
        
        self.backgroundColor = AppColors.white
        
        titleLabel.frame.origin = CGPoint(x: 20, y: 20)
        self.addSubview(titleLabel)
        
        hospitalIcon.frame.origin = CGPoint(x: 20, y: titleLabel.frame.maxY + 20)
        self.addSubview(hospitalIcon)
        
        nameLabel.text = donationBooking.donationCenter.name
        nameLabel.sizeToFit()
        nameLabel.frame.origin = CGPoint(x: hospitalIcon.frame.maxX + 10, y: titleLabel.frame.maxY + 20)
        self.addSubview(nameLabel)
        
        countyLabel.text = donationBooking.donationCenter.county
        countyLabel.sizeToFit()
        countyLabel.frame.origin = CGPoint(x: hospitalIcon.frame.maxX + 10, y: hospitalIcon.frame.maxY - countyLabel.frame.height - 4)
        self.addSubview(countyLabel)
        
        self.addressLink.frame.origin = CGPoint(x: (frame.width - addressLink.frame.width) / 2, y: countyLabel.frame.maxY + 10)
        self.addressLink.addTarget(self, action: #selector(DonationBookingView.didPressAddress(_:)), for: .touchUpInside)
        self.addSubview(addressLink)
        
        bookingTitle.frame.origin = CGPoint(x: 20, y: addressLink.frame.maxY + 20)
        self.addSubview(bookingTitle)
        
        let dateFormatter = DateFormatter()
        dateFormatter.dateFormat = "dd-MM"
        
        dateLabel.text = "Date: \(dateFormatter.string(from: donationBooking.date))"
        dateLabel.sizeToFit()
        dateLabel.frame.origin = CGPoint(x: 20, y: bookingTitle.frame.maxY + 10)
        self.addSubview(dateLabel)
        
        hourLabel.text = "Hour: \(DateUtils.getHourIntervalString(fromDate: donationBooking.date))"
        hourLabel.sizeToFit()
        hourLabel.frame.origin = CGPoint(x: 20, y: dateLabel.frame.maxY + 10)
        self.addSubview(hourLabel)
        
        donationFormTitle.frame.origin = CGPoint(x: 20, y: hourLabel.frame.maxY + 20)
        self.addSubview(donationFormTitle)
        
        donationFormSubtitle.frame.origin = CGPoint(x: 20, y: donationFormTitle.frame.maxY + 10)
        self.addSubview(donationFormSubtitle)
        
        formImageView.frame.origin = CGPoint(x: 20, y: donationFormSubtitle.frame.maxY + 20)
        self.addSubview(formImageView)
        
        formActionButton.frame.origin = CGPoint(x: formImageView.frame.maxX + 20, y: 0)
        formActionButton.center = CGPoint(x: formActionButton.center.x, y: formImageView.center.y - 4)
        formActionButton.addTarget(self, action: #selector(ProfileDetailsView.didPressFormActionButton(_:)), for: .touchUpInside)
        self.addSubview(formActionButton)
        
        actionButton.setTitle(style == .book ? "Book Donation" : "Cancel Donation", for: .normal)
        actionButton.frame = CGRect(x: CGFloat(integerLiteral: 40),
                                  y: self.frame.height - 50 - 60,
                                  width: self.frame.width - 80,
                                  height: CGFloat(integerLiteral: 50))
        self.addSubview(actionButton)
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    @objc fileprivate func didPressAddress(_ sender: UIButton) {
        
    }
    
    
    @objc fileprivate func didPressFormActionButton(_ sender: UIButton) {
        self.delegate?.donationBookingViewDidRequestForm(self)
    }
    
    @objc fileprivate func didPressMainActionBook(_ sender: UIButton) {
        switch style {
        case .book:
            self.delegate?.donationBookingViewDidRequestBook(self, donationBooking: donationBooking)
        case .view :
            self.delegate?.donationBookingViewDidRequestCancelBooking(self, donationBooking: donationBooking)
        }
    }
}
