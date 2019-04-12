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
    
    weak var delegate: MainScreenCanBookViewDelegate?
    
    private let nameLabel: UILabel = {
        let label = UILabel(frame: CGRect.zero)
        label.textColor = AppColors.almostBlack
        label.font = AppFonts.boldFontWithSize(16)
        label.contentMode = .center
        label.textAlignment = .center
        
        return label
    }()
    
    private let bookButton: ButtonWithActivity = {
        let button = ButtonWithActivity()
        button.setTitle("Book a Donation", for: .normal)
        button.setTitleColor(.white, for: .normal)
        button.backgroundColor = AppColors.appRed
        button.layer.cornerRadius = 8
        
        button.addTarget(self, action: #selector(MainScreenCanBookView.didPressBook(_:)), for: .touchUpInside)
        
        return button
    }()
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        
        nameLabel.text = "You are eligible for booking a donation!"
        nameLabel.sizeToFit()
        
        nameLabel.frame.origin = CGPoint(x: (frame.width - nameLabel.frame.width) / 2, y: 20)
        
        bookButton.frame = CGRect(x: 40,
                                   y: nameLabel.frame.maxY + 30,
                                   width: frame.width - 80,
                                   height: 50)
        self.addSubview(nameLabel)
        self.addSubview(bookButton)
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    @objc func didPressBook(_ sender: UIButton) {
        self.delegate?.mainScreenCanBookViewDidRequestBookDonation(self)
    }
}
