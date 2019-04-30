//
//  ProfileDetailsView.swift
//  EasyHelp
//
//  Created by Stefan Georgescu on 12/04/2019.
//  Copyright © 2019 EasyHelp. All rights reserved.
//

import UIKit

protocol ProfileDetailsViewDelegate: class {
    func profileDetailsViewDidRequestLogout(_ sender: ProfileDetailsView)
    func profileDetailsViewDidRequestTermsAndConditions(_ sender: ProfileDetailsView)
    func profileDetailsViewDidRequestFAQ(_ sender: ProfileDetailsView)
    func profileDetailsViewDidRequestFormActionButton(_ sender: ProfileDetailsView)
}

class ProfileDetailsView: UIView {
    var donor: DonorProfileData
    weak var delegate: ProfileDetailsViewDelegate?
    
    fileprivate struct Constants {
        static let logoSize: CGFloat = 60
    }
    
    private let profileImageView: UIImageView = {
        let image = UIImage(named: "profile_head_icon")
        let imageView = UIImageView(image: image?.resize(to: CGSize(width: Constants.logoSize, height: Constants.logoSize)))
        return imageView
    }()
    
    private let nameLabel: UILabel = {
        let label = UILabel()
        label.textColor = AppColors.almostBlack
        label.font = AppFonts.boldFontWithSize(22)
        return label
    }()
    
    private let logoutButton: ButtonWithActivity = {
        let button = ButtonWithActivity()
        button.setTitle(Strings.Misc.logout(), for: .normal)
        button.setTitleColor(.white, for: .normal)
        button.backgroundColor = AppColors.appRed
        button.layer.cornerRadius = 8
        
        button.addTarget(self, action: #selector(ProfileDetailsView.didPressLogout(_:)), for: .touchUpInside)
        
        return button
    }()
    
    private let bloodHeaderLabel: UILabel = {
        let label = UILabel()
        label.text = Strings.ProfileDetails.bloodGroupHeader()
        label.textColor = AppColors.appRed
        label.font = AppFonts.boldFontWithSize(18)
        label.sizeToFit()
        return label
    }()
    
    private let bloodImageView: UIImageView = {
        let image = UIImage(named: "profile_blood")
        let imageView = UIImageView(image: image?.resize(to: CGSize(width: Constants.logoSize, height: Constants.logoSize)))
        return imageView
    }()
    
    private let bloodLabel: UILabel = {
        let label = UILabel()
        label.textColor = AppColors.almostBlack
        label.font = AppFonts.boldFontWithSize(18)
        return label
    }()
    
    private let formHeaderLabel: UILabel = {
        let label = UILabel()
        label.text = Strings.ProfileDetails.formHeader()
        label.textColor = AppColors.appRed
        label.font = AppFonts.boldFontWithSize(18)
        label.sizeToFit()
        return label
    }()
    
    private let formImageView: UIImageView = {
        let image = UIImage(named: "profile_file")
        let imageView = UIImageView(image: image?.resize(to: CGSize(width: Constants.logoSize, height: Constants.logoSize)))
        return imageView
    }()
    
    private var formActionButton: UIButton!
    
    private let termsAndConditionsButton: UIButton = {
        let button = UIButton()
        button.setTitle(Strings.ProfileDetails.termsConds(), for: .normal)
        button.setTitleColor(AppColors.appRed, for: .normal)
        button.titleLabel?.font = AppFonts.regularFontWithSize(12)
        button.backgroundColor = .clear
        button.sizeToFit()
        button.addTarget(self, action: #selector(ProfileDetailsView.didPressTermsAndConditions), for: .touchUpInside)
        
        return button
    }()
    
    private let faqButton: UIButton = {
        let button = UIButton()
        button.setTitle(Strings.ProfileDetails.faq(), for: .normal)
        button.setTitleColor(AppColors.appRed, for: .normal)
        button.titleLabel?.font = AppFonts.regularFontWithSize(12)
        button.backgroundColor = .clear
        button.sizeToFit()
        button.addTarget(self, action: #selector(ProfileDetailsView.didPressFAQ), for: .touchUpInside)
        
        return button
    }()
    
    private let dotSeparator: UILabel = {
        let dotSeparator = UILabel()
        dotSeparator.attributedText = NSAttributedString(string: "•", attributes: [
            NSAttributedString.Key.font: AppFonts.regularFontWithSize(16),
            NSAttributedString.Key.foregroundColor: AppColors.appRed
            ])
        dotSeparator.textAlignment = NSTextAlignment.center
        dotSeparator.sizeToFit()
        return dotSeparator
    }()
    
    init(frame: CGRect, profileData: DonorProfileData) {
        donor = profileData
        super.init(frame: frame)
        
        profileImageView.frame.origin = CGPoint(x: 20, y: AppScreenUtils.screenStatusBarAndHeaderHeight + 20)
        self.addSubview(profileImageView)
        
        nameLabel.text = "\(donor.firstName) \(donor.lastName)"
        nameLabel.sizeToFit()
        nameLabel.frame.origin = CGPoint(x: profileImageView.frame.maxX + 20, y: 0)
        nameLabel.center = CGPoint(x: nameLabel.center.x, y: profileImageView.center.y - 4)
        self.addSubview(nameLabel)
        
        bloodHeaderLabel.frame.origin = CGPoint(x: 20, y: profileImageView.frame.maxY + 60)
        self.addSubview(bloodHeaderLabel)
        
        bloodImageView.frame.origin = CGPoint(x: 20, y: bloodHeaderLabel.frame.maxY + 20)
        self.addSubview(bloodImageView)
        
        if let group = profileData.bloodGroupLetter, let rh = profileData.bloodRh {
            bloodLabel.text = "\(group) \(rh ? "positive" : "negative")"
        } else {
            bloodLabel.font = AppFonts.boldFontWithSize(14)
            bloodLabel.text = Strings.ProfileDetails.bloodGroupFallback()
        }
        bloodLabel.sizeToFit()
        bloodLabel.frame.origin = CGPoint(x: bloodImageView.frame.maxX + 20, y: 0)
        bloodLabel.center = CGPoint(x: bloodLabel.center.x, y: bloodImageView.center.y - 4)
        self.addSubview(bloodLabel)
        
        formHeaderLabel.frame.origin = CGPoint(x: 20, y: bloodImageView.frame.maxY + 20)
        self.addSubview(formHeaderLabel)
        
        formImageView.frame.origin = CGPoint(x: 20, y: formHeaderLabel.frame.maxY + 20)
        self.addSubview(formImageView)
        
        formActionButton = AppInterfaceFormatter.createLink("Fill in donation form")
        formActionButton.frame.origin = CGPoint(x: formImageView.frame.maxX + 20, y: 0)
        formActionButton.center = CGPoint(x: formActionButton.center.x, y: formImageView.center.y - 4)
        formActionButton.addTarget(self, action: #selector(ProfileDetailsView.didPressFormActionButton(_:)), for: .touchUpInside)
        self.addSubview(formActionButton)
        
        let totalWidth = termsAndConditionsButton.frame.width + faqButton.frame.width + dotSeparator.frame.width + 8
        var currentX: CGFloat = (frame.width - totalWidth) / 2
        
        termsAndConditionsButton.frame.origin = CGPoint(x: currentX, y: frame.height - 220)
        addSubview(termsAndConditionsButton)
        currentX += termsAndConditionsButton.frame.width + 4
        
        dotSeparator.frame.origin = CGPoint(x: currentX, y: 0)
        dotSeparator.center.y = termsAndConditionsButton.center.y
        addSubview(dotSeparator)
        
        currentX += dotSeparator.frame.width + 4
        faqButton.frame.origin = CGPoint(x: currentX, y: frame.height - 220)
        addSubview(faqButton)
        
        logoutButton.frame = CGRect(x: 40, y: frame.height - 180, width: frame.width - 80, height: 40)
        self.addSubview(logoutButton)
        
        self.backgroundColor = .white
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    @objc func didPressLogout(_ sender: UIButton) {
        logoutButton.showLoading()
        self.delegate?.profileDetailsViewDidRequestLogout(self)
    }
    
    @objc func didPressTermsAndConditions() {
        delegate?.profileDetailsViewDidRequestTermsAndConditions(self)
    }
    
    @objc func didPressFAQ() {
        delegate?.profileDetailsViewDidRequestFAQ(self)
    }
    
    @objc func didPressFormActionButton(_ sender: UIButton) {
        delegate?.profileDetailsViewDidRequestFormActionButton(self)
    }
}
