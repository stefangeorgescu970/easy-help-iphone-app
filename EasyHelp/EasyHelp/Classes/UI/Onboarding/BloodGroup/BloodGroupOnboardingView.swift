//
//  BloodGroupOnboardingView.swift
//  EasyHelp
//
//  Created by Stefan Georgescu on 11/04/2019.
//  Copyright © 2019 EasyHelp. All rights reserved.
//

import UIKit

protocol BloodGroupOnboardingViewDelegate: class {
    func bloodGroupOnboardingViewDidRequestContinue(_ sender: BloodGroupOnboardingView, group: String, rh: Bool)
    func booddGroupOnboardingViewDidRequestSkip(_ sender: BloodGroupOnboardingView)
}

class BloodGroupOnboardingView: UIView {
    
    weak var delegate: BloodGroupOnboardingViewDelegate?
    
    private var headerView = AppInterfaceFormatter.createHeader(title: Strings.Onboarding.BloodGroup.title(), subtitle: Strings.Onboarding.BloodGroup.subtitle())
    
    private let rhLabel: UILabel = {
        let label = UILabel()
        label.text = Strings.Onboarding.BloodGroup.rh()
        label.textColor = AppColors.darkBlue
        label.font = AppFonts.boldFontWithSize(18)
        label.sizeToFit()
        return label
    }()
    
    private let rhSegmentControl: UISegmentedControl = {
        let control = UISegmentedControl(items: ["-", "+"])
        
        control.tintColor = AppColors.darkBlue
        
        return control
    }()
    
    private let groupLabel: UILabel = {
        let label = UILabel()
        label.text = Strings.Onboarding.BloodGroup.bloodGroup()
        label.textColor = AppColors.darkBlue
        label.font = AppFonts.boldFontWithSize(18)
        label.sizeToFit()
        return label
    }()
    
    private let groupTextField: UITextField = {
        let textField = UITextField()
        textField.font = AppFonts.regularFontWithSize(16)
        textField.textColor = AppColors.darkBlue
        textField.autocapitalizationType = .none
        textField.borderStyle = .none
        textField.textColor = .black
        textField.keyboardType = .numberPad
        
        return textField
    }()
    
    private let continueButton: ButtonWithActivity = {
        let button = ButtonWithActivity()
        button.setTitle(Strings.Misc.cont(), for: .normal)
        button.setTitleColor(.white, for: .normal)
        button.backgroundColor = AppColors.darkBlue
        button.layer.cornerRadius = 8
        
        button.addTarget(self, action: #selector(BloodGroupOnboardingView.didPressContinue(_:)), for: .touchUpInside)
        
        return button
    }()
    
    private let skipButton = AppInterfaceFormatter.createLink(Strings.Misc.skipForNow())
    
    let bloodGroupPicker = UIPickerView()
    
    init(frame: CGRect, pickerDelegate: UIPickerViewDelegate, pickerDataSource: UIPickerViewDataSource) {
        super.init(frame: frame)
        
        headerView.frame = CGRect(x: 20, y: 60, width: frame.width - 2 * 20, height: 65)
        
        var currentY = headerView.frame.maxY + 60
        
        rhLabel.frame.origin = CGPoint(x: 20, y: currentY)
        currentY += rhLabel.frame.height + 20
        
        rhSegmentControl.frame = CGRect(x: 20, y: currentY, width: frame.width - 40, height: 40)
        
        currentY += rhSegmentControl.frame.height + 20
        
        groupLabel.frame.origin = CGPoint(x: 20, y: currentY)
        currentY += groupLabel.frame.height + 20
        
        groupTextField.frame = CGRect(x: 20, y: currentY, width: frame.width - 40, height: 40)
        
        continueButton.frame = CGRect(x: 40, y: frame.height - 100, width: frame.width - 80, height: 40)
        
        skipButton.frame = CGRect(x: (frame.width - skipButton.frame.width) / 2, y: continueButton.frame.minY - skipButton.frame.height - 30, width: skipButton.frame.width, height: skipButton.frame.height)
        
        self.addSubview(skipButton)
        
        self.addSubview(continueButton)
        self.addSubview(groupLabel)
        self.addSubview(rhLabel)
        
        self.addSubview(headerView)
        self.addSubview(rhSegmentControl)
        self.addSubview(groupTextField)
        
        AppInterfaceFormatter.addUnderline(toTextField: groupTextField)
        
        self.backgroundColor = AppColors.white
        
        createPickerView(delegate: pickerDelegate, dataSource: pickerDataSource)
        createToolbar()
        skipButton.addTarget(self, action: #selector(BloodGroupOnboardingView.didChooseSkip), for: .touchUpInside)
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    func setCurrentBloodGroup(_ group: String) {
        groupTextField.text = group
    }
    
    fileprivate func createPickerView(delegate: UIPickerViewDelegate, dataSource: UIPickerViewDataSource) {
        bloodGroupPicker.delegate = delegate
        bloodGroupPicker.dataSource = dataSource
        groupTextField.text = Strings.Onboarding.BloodGroup.bloodGroupDefaultValue()
        groupTextField.inputView = bloodGroupPicker
        bloodGroupPicker.backgroundColor = AppColors.white
    }
    
    fileprivate func createToolbar() {
        let toolbar = UIToolbar()
        toolbar.sizeToFit()
        toolbar.tintColor = AppColors.darkBlue
        toolbar.backgroundColor = AppColors.white
        let doneButton = UIBarButtonItem(title: Strings.Misc.done(), style: .plain, target: self, action: #selector(BloodGroupOnboardingView.closePickerView))
        toolbar.setItems([doneButton], animated: false)
        toolbar.isUserInteractionEnabled = true
        groupTextField.inputAccessoryView = toolbar
    }
    
    private func isDataValid() -> Bool {
        if groupTextField.text! == Strings.Onboarding.BloodGroup.bloodGroupDefaultValue() {
            return false
        }
        
        if rhSegmentControl.selectedSegmentIndex == UISegmentedControl.noSegment {
            return false
        }
        
        return true
    }
    
    @objc fileprivate func didPressContinue(_ sender: UIButton) {
        if !isDataValid() {
            // TODO :- show error
            return
        }
        
        let bloodGroup = groupTextField.text!
        let rh = rhSegmentControl.selectedSegmentIndex == 1
        
       self.delegate?.bloodGroupOnboardingViewDidRequestContinue(self, group: bloodGroup, rh: rh)
    }
    
    @objc func closePickerView() {
        self.endEditing(true)
    }
    
    @objc func didChooseSkip() {
        self.delegate?.booddGroupOnboardingViewDidRequestSkip(self)
    }
}
