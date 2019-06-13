//
//  MainScreenView.swift
//  EasyHelp
//
//  Created by Stefan Georgescu on 11/04/2019.
//  Copyright © 2019 EasyHelp. All rights reserved.
//

import UIKit

protocol MainScreenViewDelegate: class {
    func mainScreenViewDidRequestBookDonation(_ sender: MainScreenView)
    func mainScreenViewDidRequestShowDonation(_ sender: MainScreenView, donationBooking: DonationBooking)
    func mainScreenViewDidRequestShowWhy(_ sender: MainScreenView)
    func mainScreenViewDidRequestShowHow(_ sender: MainScreenView)
    func mainScreenViewDidRequestShowRecentDonation(_ sender: MainScreenView, donation: Donation)
}

class MainScreenView: UIView {
    
    private typealias AccIds = TestStrings.App.MainScreen
    
    weak var delegate: MainScreenViewDelegate?
    var donorSummary: DonorSummaryData?
    
    private let logoLabel: UILabel = {
        let label = UILabel(frame: CGRect.zero)
        label.textColor = AppColors.appRed
        label.font = AppFonts.boldFontWithSize(22)
        label.contentMode = .center
        label.textAlignment = .center
        label.accessibilityIdentifier = AccIds.logo
        
        return label
    }()
    
    private let nameLabel: UILabel = {
        let label = UILabel(frame: CGRect.zero)
        label.textColor = AppColors.almostBlack
        label.font = AppFonts.boldFontWithSize(20)
        label.contentMode = .center
        label.textAlignment = .center
        label.accessibilityIdentifier = AccIds.name
        
        return label
    }()
    
    private let donatedLabel: UILabel = {
        let label = UILabel(frame: CGRect.zero)
        label.textColor = AppColors.almostBlack
        label.font = AppFonts.regularFontWithSize(16)
        label.contentMode = .center
        label.textAlignment = .center
        label.accessibilityIdentifier = AccIds.donated
        
        return label
    }()
    
    private var encourageLabel = AppInterfaceFormatter.createLongLabel(text: "Did you know that one donation can help up to 3 people? It is a really easy way to help!")
    
    private let whyButton = AppInterfaceFormatter.createLink("Why?")
    private let howButton = AppInterfaceFormatter.createLink("How?")
    
    private var canBookView: MainScreenCanBookView?
    private var nextBookingView: MainScreenNextBookingView?
    private var recentDonationView: MainScreenRecentDonationView?
    private var cannotDonateView: MainScreenTooManyDonationsView?
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        accessibilityIdentifier = AccIds.view
        
        encourageLabel.accessibilityIdentifier = AccIds.encourage
        whyButton.accessibilityIdentifier = AccIds.whyButton
        howButton.accessibilityIdentifier = AccIds.howButton
    
        self.addSubview(logoLabel)
        self.addSubview(nameLabel)
        self.addSubview(donatedLabel)
        self.addSubview(encourageLabel)
        self.addSubview(whyButton)
        self.addSubview(howButton)
        
        whyButton.addTarget(self, action: #selector(MainScreenView.didPressWhy(_:)), for: .touchUpInside)
        howButton.addTarget(self, action: #selector(MainScreenView.didPressHow(_:)), for: .touchUpInside)
        
        self.backgroundColor = .white
    }
    
    func syncView(forBooking booking: DonationBooking?) {
        if let booking = booking {
            if let canBookView = canBookView {
                canBookView.removeFromSuperview()
                self.canBookView = nil
            }
            
            nextBookingView = MainScreenNextBookingView(frame: CGRect(x: 0,
                                                                      y: frame.height - 200 - 60,
                                                                      width: frame.width,
                                                                      height: 200), booking: booking)
            nextBookingView?.delegate = self
            self.addSubview(nextBookingView!)
        } else {
            if let nextBookingView = nextBookingView {
                nextBookingView.removeFromSuperview()
                self.nextBookingView = nil
            }
            
            canBookView = MainScreenCanBookView(frame: CGRect(x: 0,
                                                              y: frame.height - 200 - 60,
                                                              width: frame.width,
                                                              height: 200),
                                                numberOfPeople: donorSummary?.numberOfPeopleYouCouldHelp ?? -1)
            canBookView?.delegate = self
            self.addSubview(canBookView!)
        }
    }
    
    func syncView(profileData: DonorProfileData, donorSummary: DonorSummaryData) {
        self.donorSummary = donorSummary
        
        logoLabel.text = "Easy Help"
        logoLabel.sizeToFit()
        
        logoLabel.frame.origin = CGPoint(x: (frame.width - logoLabel.frame.width) / 2, y: AppScreenUtils.screenStatusBarHeight + 20)
        
        nameLabel.text = "\(profileData.firstName) \(profileData.lastName)"
        nameLabel.sizeToFit()
        nameLabel.frame.origin = CGPoint(x: 20, y: logoLabel.frame.maxY + 40)
        
        donatedLabel.text = "You have donated \(donorSummary.donationNumber) times."
        donatedLabel.sizeToFit()
        donatedLabel.frame.origin = CGPoint(x: 20, y: nameLabel.frame.maxY + 10)
        
        encourageLabel.frame.origin = CGPoint(x: 20, y: donatedLabel.frame.maxY + 40)
        howButton.frame.origin = CGPoint(x: 40, y: encourageLabel.frame.maxY + 20)
        whyButton.frame.origin = CGPoint(x: frame.width - whyButton.frame.width - 40, y: encourageLabel.frame.maxY + 20)
        
        if let streakBegin = donorSummary.streakBegin {
            cannotDonateView = MainScreenTooManyDonationsView(frame: CGRect(x: 0,
                                                                            y: frame.height - 200 - 60,
                                                                            width: frame.width,
                                                                            height: 200),
                                                              beginDate: streakBegin)
            self.addSubview(cannotDonateView!)
        } else if let donation = donorSummary.lastDonation, let daysUntil = DonationUtils.getNumberOfDaysUntilCanDonate(lastDonation: donation) {
            recentDonationView = MainScreenRecentDonationView(frame: CGRect(x: 0,
                                                                            y: frame.height - 200 - 60,
                                                                            width: frame.width,
                                                                            height: 200),
                                                              donation: donation,
                                                              daysUntilCanDonate: daysUntil)
            recentDonationView?.delgate = self
            self.addSubview(recentDonationView!)
        } else if let nextBooking = donorSummary.nextBooking {
            nextBookingView = MainScreenNextBookingView(frame: CGRect(x: 0,
                                                                      y: frame.height - 200 - 60,
                                                                      width: frame.width,
                                                                      height: 200),
                                                        booking: nextBooking)
            nextBookingView?.delegate = self
            self.addSubview(nextBookingView!)
        } else {
            canBookView = MainScreenCanBookView(frame: CGRect(x: 0,
                                                              y: frame.height - 200 - 60,
                                                              width: frame.width,
                                                              height: 200),
                                                numberOfPeople: donorSummary.numberOfPeopleYouCouldHelp)
            canBookView?.delegate = self
            self.addSubview(canBookView!)
        }
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    @objc private func didPressWhy(_ sender: UIButton) {
        self.delegate?.mainScreenViewDidRequestShowWhy(self)
    }
    
    @objc private func didPressHow(_ sender: UIButton) {
        self.delegate?.mainScreenViewDidRequestShowHow(self)
    }
}

extension MainScreenView: MainScreenCanBookViewDelegate {
    func mainScreenCanBookViewDidRequestBookDonation(_ sender: MainScreenCanBookView) {
        self.delegate?.mainScreenViewDidRequestBookDonation(self)
    }
}

extension MainScreenView: MainScreenNextBookingViewDelegate {
    func mainScreenNextBookingViewDidRequestShowBooking(_ sender: MainScreenNextBookingView, booking: DonationBooking) {
        self.delegate?.mainScreenViewDidRequestShowDonation(self, donationBooking: booking)
    }
}

extension MainScreenView: MainScreenRecentDonationViewDelegate {
    func mainScreenRecentDonationView(_ view: MainScreenRecentDonationView, didRequestViewDonation donation: Donation) {
        self.delegate?.mainScreenViewDidRequestShowRecentDonation(self, donation: donation)
    }
}
