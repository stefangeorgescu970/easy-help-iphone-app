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
    func mainScreenViewDidRequestShowWhy(_ sender: MainScreenView)
    func mainScreenViewDidRequestShowHow(_ sender: MainScreenView)
}

class MainScreenView: UIView {
    
    weak var delegate: MainScreenViewDelegate?
    
    private let logoLabel: UILabel = {
        let label = UILabel(frame: CGRect.zero)
        label.textColor = AppColors.appRed
        label.font = AppFonts.boldFontWithSize(22)
        label.contentMode = .center
        label.textAlignment = .center
        
        return label
    }()
    
    private let nameLabel: UILabel = {
        let label = UILabel(frame: CGRect.zero)
        label.textColor = AppColors.almostBlack
        label.font = AppFonts.boldFontWithSize(20)
        label.contentMode = .center
        label.textAlignment = .center
        
        return label
    }()
    
    private let donatedLabel: UILabel = {
        let label = UILabel(frame: CGRect.zero)
        label.textColor = AppColors.almostBlack
        label.font = AppFonts.regularFontWithSize(16)
        label.contentMode = .center
        label.textAlignment = .center
        
        return label
    }()
    
    private var encourageLabel = AppInterfaceFormatter.createLongLabel(text: "Did you know that one donation can help up to 3 people? It is a really easy way to help!")
    
    private let whyButton = AppInterfaceFormatter.createLink("Why?")
    private let howButton = AppInterfaceFormatter.createLink("How?")
    
    private var canBookView: MainScreenCanBookView?
    
    override init(frame: CGRect) {
        super.init(frame: frame)
    
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
    
    func syncView(profileData: DonorProfileData, donorSummary: DonorSummaryData) {
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
        
        if let _ = donorSummary.lastDonation {
            
        } else if let _ = donorSummary.nextBooking {
            
        } else {
            canBookView = MainScreenCanBookView(frame: CGRect(x: 0,
                                                              y: frame.height - 200 - 60,
                                                              width: frame.width,
                                                              height: 200))
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
