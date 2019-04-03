//
//  BloodGroupOnboardingViewController.swift
//  EasyHelp
//
//  Created by Stefan Georgescu on 03/04/2019.
//  Copyright © 2019 EasyHelp. All rights reserved.
//

import UIKit

class BloodGroupOnboardingViewController: UIViewController {
    
    private var arrayOfBloodGroups = ["Select Blood Group", "A", "B", "AB", "0"]
    
    private var headerView = AppInterfaceFormatter.createHeader(title: "Blood Group", subtitle: "In order to match you with potential donors or people in need of blood, we need to know your blood group")
    
    private let rhLabel: UILabel = {
        let label = UILabel()
        label.text = "Rh"
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
        label.text = "Your Blood Group"
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
        button.setTitle("Continue", for: .normal)
        button.setTitleColor(.white, for: .normal)
        button.backgroundColor = AppColors.darkBlue
        button.layer.cornerRadius = 8
        
        button.addTarget(self, action: #selector(BloodGroupOnboardingViewController.didPressContinue(_:)), for: .touchUpInside)
        
        return button
    }()
    
    let countyPicker = UIPickerView()
    
    @objc fileprivate func didPressContinue(_ sender: UIButton) {
        self.navigationController?.pushViewController(DonorFormOnboardingViewController(), animated: true)
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        headerView.frame = CGRect(x: 20, y: 60, width: view.bounds.width - 2 * 20, height: 65)
        
        var currentY = headerView.frame.maxY + 60
        
        rhLabel.frame.origin = CGPoint(x: 20, y: currentY)
        currentY += rhLabel.frame.height + 20
        
        rhSegmentControl.frame = CGRect(x: 20, y: currentY, width: view.bounds.width - 40, height: 40)
        
        currentY += rhSegmentControl.frame.height + 20
        
        groupLabel.frame.origin = CGPoint(x: 20, y: currentY)
        currentY += groupLabel.frame.height + 20
        
        groupTextField.frame = CGRect(x: 20, y: currentY, width: view.bounds.width - 40, height: 40)
        
        continueButton.frame = CGRect(x: 40, y: view.bounds.height - 100, width: view.bounds.width - 80, height: 40)
        
        self.view.addSubview(continueButton)
        self.view.addSubview(groupLabel)
        self.view.addSubview(rhLabel)
        
        self.view.addSubview(headerView)
        self.view.addSubview(rhSegmentControl)
        self.view.addSubview(groupTextField)
        
        AppInterfaceFormatter.addUnderline(toTextField: groupTextField)
        
        self.view.backgroundColor = AppColors.white
        
        createPickerView()
        createToolbar()
        
        self.navigationController?.navigationBar.isHidden = true
    }
    
    fileprivate func createPickerView() {
        countyPicker.delegate = self
        countyPicker.delegate?.pickerView?(countyPicker, didSelectRow: 0, inComponent: 0)
        groupTextField.inputView = countyPicker
        countyPicker.backgroundColor = AppColors.white
    }
    
    fileprivate func createToolbar() {
        let toolbar = UIToolbar()
        toolbar.sizeToFit()
        toolbar.tintColor = AppColors.darkBlue
        toolbar.backgroundColor = AppColors.white
        let doneButton = UIBarButtonItem(title: "Done", style: .plain, target: self, action: #selector(CountySSNOnboardingViewController.closePickerView))
        toolbar.setItems([doneButton], animated: false)
        toolbar.isUserInteractionEnabled = true
        groupTextField.inputAccessoryView = toolbar
    }
    
    @objc func closePickerView() {
        view.endEditing(true)
    }
}

extension BloodGroupOnboardingViewController: UIPickerViewDelegate {
    func pickerView(_ pickerView: UIPickerView, titleForRow row: Int, forComponent component: Int) -> String? {
        return arrayOfBloodGroups[row]
    }
    
    func pickerView(_ pickerView: UIPickerView, didSelectRow row: Int, inComponent component: Int) {
        groupTextField.text =  arrayOfBloodGroups[row]
    }
    
    func pickerView(_ pickerView: UIPickerView, widthForComponent component: Int) -> CGFloat {
        return 300
    }
    
    func pickerView(_ pickerView: UIPickerView, rowHeightForComponent component: Int) -> CGFloat {
        return 60.0
    }
    
    func pickerView(_ pickerView: UIPickerView, viewForRow row: Int, forComponent component: Int, reusing view: UIView?) -> UIView {
        
        var label:UILabel
        
        if let v = view as? UILabel{
            label = v
        }
        else{
            label = UILabel()
        }
        
        label.textColor = AppColors.darkBlue
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
