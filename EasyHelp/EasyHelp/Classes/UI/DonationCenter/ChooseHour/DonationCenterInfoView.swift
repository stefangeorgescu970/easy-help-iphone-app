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
    func donationCenterInfoViewDidRequestForm(_ sender: DonationCenterInfoView)
    func donationCenterInfoViewSetSSN(_sender: DonationCenterInfoView, ssn: String)
}

class DonationCenterInfoView: UIView {
    
    weak var delegate: DonationCenterInfoViewDelegate?
    var donationCenter: DonationCenter
    var isShowingError: Bool = false
    
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
    
    private let donatingForSomeoneLabel: UILabel = {
        let label = UILabel()
        label.textColor = AppColors.appRed
        label.font = AppFonts.boldFontWithSize(16)
        label.text = "Donating for someone? Add their SSN."
        label.sizeToFit()
        return label
    }()
    
    private let ssnInputField: UITextField = {
        let textField = UITextField()
        textField.attributedPlaceholder = NSAttributedString(string: "Patient SSN",
                                                             attributes: [NSAttributedString.Key.foregroundColor: UIColor.lightGray])
        textField.autocapitalizationType = .none
        textField.textContentType = .emailAddress
        textField.borderStyle = .none
        textField.textColor = .black
        textField.keyboardType = .numberPad
        
        textField.addTarget(self, action: #selector(DonationCenterInfoView.userEditedText), for: .editingChanged)
        
        let toolbar = UIToolbar()
        toolbar.sizeToFit()
        toolbar.tintColor = AppColors.appRed
        toolbar.backgroundColor = AppColors.white
        let doneButton = UIBarButtonItem(title: Strings.Misc.done(), style: .plain, target: self, action: #selector(DonationCenterInfoView.closeSsnKeyboard))
        toolbar.setItems([doneButton], animated: false)
        toolbar.isUserInteractionEnabled = true
        textField.inputAccessoryView = toolbar
        
        return textField
    }()
    
    private let messageLabel: UILabel = {
        let label = UILabel(frame: CGRect.zero)
        label.textColor = AppColors.accentRed
        label.font = AppFonts.boldFontWithSize(16)
        label.contentMode = .center
        label.textAlignment = .center
        
        return label
    }()
    
    private let chooseHourLabel: UILabel = {
        let label = UILabel()
        label.textColor = AppColors.appRed
        label.font = AppFonts.regularFontWithSize(16)
        label.text = "Please choose a date and an hour."
        label.sizeToFit()
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
        
        donatingForSomeoneLabel.frame.origin = CGPoint(x: 20, y: addressLink.frame.maxY + 20)
        addSubview(donatingForSomeoneLabel)
        
        ssnInputField.frame = CGRect(x: 20,
                                     y: donatingForSomeoneLabel.frame.maxY + 20,
                                     width: frame.width - 2 * 20,
                                     height: 44)
        AppInterfaceFormatter.addUnderline(toTextField: ssnInputField)
        addSubview(ssnInputField)
        
        messageLabel.frame = CGRect(x: 0,
                                    y: ssnInputField.frame.origin.y,
                                    width: frame.width,
                                    height: 40)
        addSubview(messageLabel)
        messageLabel.alpha = 0
        
        scrollView.showsVerticalScrollIndicator = false
        scrollView.translatesAutoresizingMaskIntoConstraints = false
        scrollView.showsHorizontalScrollIndicator = false
        self.addSubview(scrollView)
        
        self.chooseHourLabel.frame.origin = CGPoint(x: (frame.width - chooseHourLabel.frame.width) / 2,
                                                    y: self.scrollView.frame.minY - chooseHourLabel.frame.height - 10)
        self.addSubview(self.chooseHourLabel)
        
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
    
    func showMessage(withText: String, isError: Bool) {
        if !isShowingError {
            isShowingError = true
            self.messageLabel.text = withText
            self.messageLabel.textColor = isError ? AppColors.appRed : AppColors.almostBlack
            
            UIView.animateKeyframes(withDuration: 0.4, delay: 0, options: [], animations: {
                UIView.addKeyframe(withRelativeStartTime: 0, relativeDuration: 1, animations: {
                    self.messageLabel.frame = self.messageLabel.frame.offsetBy(dx: 0, dy: 50)
                })
                
                UIView.addKeyframe(withRelativeStartTime: 0.5, relativeDuration: 0.5, animations: {
                    self.messageLabel.alpha = 1
                })
            })
        }
    }
    
    func stopShowingMessage() {
        if isShowingError {
            isShowingError = false
            
            UIView.animateKeyframes(withDuration: 0.4, delay: 0, options: [], animations: {
                UIView.addKeyframe(withRelativeStartTime: 0, relativeDuration: 1, animations: {
                    self.messageLabel.frame = self.messageLabel.frame.offsetBy(dx: 0, dy: -50)
                })
                
                UIView.addKeyframe(withRelativeStartTime: 0, relativeDuration: 0.5, animations: {
                    self.messageLabel.alpha = 0
                })
            })
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
    
    @objc fileprivate func didPressFormActionButton(_ sender: UIButton) {
        self.delegate?.donationCenterInfoViewDidRequestForm(self)
    }
    
    @objc fileprivate func userEditedText() {
        self.stopShowingMessage()
    }
    
    @objc fileprivate func closeSsnKeyboard() {
        ssnInputField.resignFirstResponder()
        
        AppServices.donorService.checkPatientSSN(ssnInputField.text!) { (error) in
            if let error = error {
                self.showMessage(withText: error.myErrorInfo, isError: true)
            } else {
                self.showMessage(withText: "Your donation will be registered for this SSN.", isError: false)
                self.delegate?.donationCenterInfoViewSetSSN(_sender: self, ssn: self.ssnInputField.text!)
            }
        }
    }
}
