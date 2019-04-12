//
//  BloodGroupOnboardingViewController.swift
//  EasyHelp
//
//  Created by Stefan Georgescu on 03/04/2019.
//  Copyright © 2019 EasyHelp. All rights reserved.
//

import UIKit

class BloodGroupOnboardingViewController: UIViewController {
    
    private var arrayOfBloodGroups = [Strings.Onboarding.BloodGroup.bloodGroupDefaultValue(), "A", "B", "AB", "0"]
    private var innerView: BloodGroupOnboardingView!
    
    init() {
        super.init(nibName: nil, bundle: nil)
        innerView = BloodGroupOnboardingView(frame: UIScreen.main.bounds, pickerDelegate: self, pickerDataSource: self)
        innerView.delegate = self
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.view = innerView
       
        self.navigationController?.navigationBar.isHidden = true
    }
}

extension BloodGroupOnboardingViewController: UIPickerViewDelegate {
    func pickerView(_ pickerView: UIPickerView, titleForRow row: Int, forComponent component: Int) -> String? {
        return arrayOfBloodGroups[row]
    }
    
    func pickerView(_ pickerView: UIPickerView, didSelectRow row: Int, inComponent component: Int) {
        innerView.setCurrentBloodGroup(arrayOfBloodGroups[row])
    }
    
    func pickerView(_ pickerView: UIPickerView, widthForComponent component: Int) -> CGFloat {
        return 300
    }
    
    func pickerView(_ pickerView: UIPickerView, rowHeightForComponent component: Int) -> CGFloat {
        return 60.0
    }
    
    func pickerView(_ pickerView: UIPickerView, viewForRow row: Int, forComponent component: Int, reusing view: UIView?) -> UIView {
        var label:UILabel
        
        if let v = view as? UILabel {
            label = v
        } else {
            label = UILabel()
        }
        
        label.textColor = AppColors.appRed
        label.textAlignment = .left
        label.font = UIFont(name: "Helvetica", size: 16)
        
        label.text = arrayOfBloodGroups[row]
        
        return label
    }
}

extension BloodGroupOnboardingViewController: UIPickerViewDataSource {
    func numberOfComponents(in pickerView: UIPickerView) -> Int {
        return 1
    }
    
    func pickerView(_ pickerView: UIPickerView, numberOfRowsInComponent component: Int) -> Int {
        return arrayOfBloodGroups.count
    }
}

extension BloodGroupOnboardingViewController: BloodGroupOnboardingViewDelegate {
    func bloodGroupOnboardingViewDidRequestContinue(_ sender: BloodGroupOnboardingView, group: String, rh: Bool) {
        AppServices.profileService.updateBloodGroup(bloodGroup: group, rh: rh) { (error) in
            if let error = error {
                // show error
            } else {
                let profileData = AppServices.profileService.getCurrentUser()!
                profileData.bloodGroupLetter = group
                profileData.bloodRh = rh
                AppServices.profileService.saveCurrentUser(profileData)
                self.navigationController?.pushViewController(DonorFormOnboardingViewController(), animated: true)
            }
        }
    }
    
    func booddGroupOnboardingViewDidRequestSkip(_ sender: BloodGroupOnboardingView) {
        self.navigationController?.pushViewController(DonorFormOnboardingViewController(), animated: true)
    }
}
