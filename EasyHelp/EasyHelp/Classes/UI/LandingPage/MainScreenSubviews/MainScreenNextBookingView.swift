//
//  MainScreenNextBookingView.swift
//  EasyHelp
//
//  Created by Stefan Georgescu on 13/04/2019.
//  Copyright © 2019 EasyHelp. All rights reserved.
//

import UIKit

protocol MainScreenNextBookingViewDelegate: class {
    func mainScreenNextBookingViewDidRequestShowBooking(_ sender: MainScreenNextBookingView, booking: DonationBooking)
}

class MainScreenNextBookingView: UIView {
    weak var delegate: MainScreenNextBookingViewDelegate?
    var donationBooking: DonationBooking
    
    private let titleLabel: UILabel = {
        let label = UILabel(frame: CGRect.zero)
        label.textColor = AppColors.almostBlack
        label.font = AppFonts.boldFontWithSize(16)
        label.contentMode = .center
        label.textAlignment = .center
        
        return label
    }()
    
    private let bookingIcon: UIImageView = {
        let image = UIImage(named: "donation_booking_landing")
        let imageView = UIImageView(image: image?.resize(to: CGSize(width: 60, height: 60)))
        return imageView
    }()
    
    private let nameLabel: UILabel = {
        let label = UILabel(frame: CGRect.zero)
        label.textColor = AppColors.almostBlack
        label.font = AppFonts.regularFontWithSize(14)
        label.contentMode = .center
        label.textAlignment = .center
        
        return label
    }()
    
    private let dateLabel: UILabel = {
        let label = UILabel(frame: CGRect.zero)
        label.textColor = AppColors.almostBlack
        label.font = AppFonts.regularFontWithSize(14)
        label.contentMode = .center
        label.textAlignment = .center
        
        return label
    }()
    
    private let infoIcon: UIImageView = {
        let image = UIImage(named: "ic_info")
        let imageView = UIImageView(image: image?.resize(to: CGSize(width: 40, height: 40)))
        return imageView
    }()
    
    init(frame: CGRect, booking: DonationBooking) {
        self.donationBooking = booking
        super.init(frame: frame)
        
        titleLabel.text = "Your next donation booking"
        titleLabel.sizeToFit()
        titleLabel.frame.origin = CGPoint(x: (frame.width - titleLabel.frame.width) / 2, y: 20)
        self.addSubview(titleLabel)
        
        bookingIcon.frame.origin = CGPoint(x: 20, y: titleLabel.frame.maxY + 20)
        self.addSubview(bookingIcon)
        
        nameLabel.text = booking.donationCenter.name
        nameLabel.sizeToFit()
        nameLabel.frame.origin = CGPoint(x: bookingIcon.frame.maxX + 10, y: bookingIcon.frame.origin.y)
        self.addSubview(nameLabel)
        
        dateLabel.text = DateUtils.getBookingDateDescription(booking.date)
        dateLabel.sizeToFit()
        dateLabel.frame.origin = CGPoint(x: bookingIcon.frame.maxX + 10, y: bookingIcon.frame.maxY - dateLabel.frame.height - 4)
        self.addSubview(dateLabel)
        
        infoIcon.frame.origin = CGPoint(x: frame.width - 20 - infoIcon.frame.width, y: bookingIcon.frame.origin.y + 10 - 4)
        self.addSubview(infoIcon)
        
        let gestureRecogniser = UITapGestureRecognizer(target: self, action: #selector(MainScreenNextBookingView.infoIconTapped(_:)))
        infoIcon.addGestureRecognizer(gestureRecogniser)
        infoIcon.isUserInteractionEnabled = true
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    @objc private func infoIconTapped(_ sender: UITapGestureRecognizer) {
        self.delegate?.mainScreenNextBookingViewDidRequestShowBooking(self, booking: donationBooking)
    }
}
