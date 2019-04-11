//
//  CountySSNOnboardingViewController.swift
//  EasyHelp
//
//  Created by Stefan Georgescu on 03/04/2019.
//  Copyright © 2019 EasyHelp. All rights reserved.
//

import UIKit

class CountySSNOnboardingViewController: UIViewController {
    
    private var arrayOfCounties = [Strings.Onboarding.CountySSN.countyDefaultValue()]
    private var innerView: CountySSNOnboardingView?
    
    init() {
        super.init(nibName: nil, bundle: nil)
        self.innerView = CountySSNOnboardingView(frame: UIScreen.main.bounds, pickerDelegate: self, pickerDataSource: self)
        self.innerView?.delegate = self
        
        AppServices.miscService.getCounties { (counties, error) in
            if let counties = counties {
                self.arrayOfCounties.append(contentsOf: counties)
                self.innerView?.reloadPickerData()
            } else {
                // handle error
            }
        }
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

extension CountySSNOnboardingViewController: UIPickerViewDelegate {
    func pickerView(_ pickerView: UIPickerView, titleForRow row: Int, forComponent component: Int) -> String? {
        return arrayOfCounties[row]
    }
    
    func pickerView(_ pickerView: UIPickerView, didSelectRow row: Int, inComponent component: Int) {
        innerView?.setCurrentCounty(arrayOfCounties[row])
    }
    
    func pickerView(_ pickerView: UIPickerView, widthForComponent component: Int) -> CGFloat {
        return 300
    }
    
    func pickerView(_ pickerView: UIPickerView, rowHeightForComponent component: Int) -> CGFloat {
        return 60.0
    }
    
    func pickerView(_ pickerView: UIPickerView, viewForRow row: Int, forComponent component: Int, reusing view: UIView?) -> UIView {
        var label: UILabel
        
        if let v = view as? UILabel {
            label = v
        } else {
            label = UILabel()
        }
        
        label.textColor = AppColors.darkBlue
        label.textAlignment = .left
        label.font = UIFont(name: "Helvetica", size: 16)
        
        label.text = arrayOfCounties[row].replacingOccurrences(of: "_", with: " ")
        
        return label
    }
}

extension CountySSNOnboardingViewController: UIPickerViewDataSource {
    func numberOfComponents(in pickerView: UIPickerView) -> Int {
        return 1
    }
    
    func pickerView(_ pickerView: UIPickerView, numberOfRowsInComponent component: Int) -> Int {
        return arrayOfCounties.count
    }
}

extension CountySSNOnboardingViewController: CountySSNOnboardingViewDelegate {
    func countySsnOnboardingViewDelegateDidRequestContinue(_ sender: CountySSNOnboardingView, withCountyIndex countyIndex: Int, ssn: String) {
        AppServices.profileService.updateCountyAndSSN(newCounty: arrayOfCounties[countyIndex], newSSN: ssn) { (error) in
            if let error = error {
                self.innerView?.showError(withText: error.myErrorInfo)
            } else {
                let profileData = AppServices.profileService.getCurrentUser()!
                profileData.county = self.arrayOfCounties[countyIndex]
                profileData.ssn = ssn
                AppServices.profileService.saveCurrentUser(profileData)
                self.navigationController?.pushViewController(BloodGroupOnboardingViewController(), animated: true)
            }
        }
    }
}
