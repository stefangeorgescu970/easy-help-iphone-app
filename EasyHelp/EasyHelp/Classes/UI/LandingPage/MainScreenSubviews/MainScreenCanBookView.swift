//
//  MainScreenCanBookView.swift
//  EasyHelp
//
//  Created by Stefan Georgescu on 11/04/2019.
//  Copyright © 2019 EasyHelp. All rights reserved.
//

import UIKit

protocol MainScreenCanBookViewDelegate: class {
    func mainScreenCanBookViewDidRequestBookDonation(_ sender: MainScreenCanBookView)
}

class MainScreenCanBookView: UIView {
    
    private typealias AccIds = TestStrings.App.MainScreen.CanBook
    
    weak var delegate: MainScreenCanBookViewDelegate?
    
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
    
    private let bookButton: ButtonWithActivity = {
        let button = ButtonWithActivity()
        button.setTitle("Book a Donation", for: .normal)
        button.setTitleColor(.white, for: .normal)
        button.backgroundColor = AppColors.appRed
        button.layer.cornerRadius = 8
        button.accessibilityIdentifier = AccIds.button
        
        button.addTarget(self, action: #selector(MainScreenCanBookView.didPressBook(_:)), for: .touchUpInside)
        
        return button
    }()
    
    init(frame: CGRect, numberOfPeople: Int?) {
        super.init(frame: frame)
        accessibilityIdentifier = AccIds.view
        
        titleLabel.text = "You are eligible for booking a donation!"
        titleLabel.sizeToFit()
        titleLabel.frame.origin = CGPoint(x: (frame.width - titleLabel.frame.width) / 2, y: 20)
        
        bookButton.frame = CGRect(x: 40,
                                  y: titleLabel.frame.maxY + 30,
                                  width: frame.width - 80,
                                  height: 50)
        
        if let numberOfPeople = numberOfPeople, numberOfPeople > -1 {
            titleLabel.frame.origin = CGPoint(x: (frame.width - titleLabel.frame.width) / 2, y: 0)
            bookButton.frame.origin = CGPoint(x: 40, y: titleLabel.frame.maxY + 60)
            
            subtitleLabel.text = "\(numberOfPeople) people need your blood type at this moment."
            subtitleLabel.sizeToFit()
            subtitleLabel.frame.origin = CGPoint(x: (frame.width - subtitleLabel.frame.width) / 2, y: titleLabel.frame.maxY + 10)
            addSubview(subtitleLabel)
        }        
        
        self.addSubview(titleLabel)
        self.addSubview(bookButton)
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    @objc func didPressBook(_ sender: UIButton) {
        self.delegate?.mainScreenCanBookViewDidRequestBookDonation(self)
    }
}
