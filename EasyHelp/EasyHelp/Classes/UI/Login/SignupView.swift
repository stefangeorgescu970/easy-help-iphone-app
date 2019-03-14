//
//  SignupView.swift
//  AcademicInfo
//
//  Created by Stefan Georgescu on 10/11/2018.
//  Copyright © 2018 Stefan Georgescu. All rights reserved.
//

import UIKit

protocol SignupViewDelegate: class {
    func signupViewDidRequestSignUp(_ signupView: SignupView, withName name: String, withEmail email: String, withPassword password: String)
    func signupViewDidRequestLoginPage(_ signupView: SignupView)
}

class SignupView: UIView {
    
    // MARK: - Properties Declaration
    
    fileprivate struct Constants {
        static let leftMargin: CGFloat = 40
        static let rowSpacing: CGFloat = 14
        static let labelSpacing: CGFloat = 4
    }
    
    private var isShowingError: Bool = false
    weak var delegate: SignupViewDelegate?
    
    // MARK: - View Properties Declaration
    
    private let titleLabel: UILabel = {
        let label = UILabel()
        label.text = Strings.Signup.title()
        label.textColor = AppColors.almostBlack
        label.font = AppFonts.boldFontWithSize(24)
        label.sizeToFit()
        return label
    }()
    
    private let nameLabel: UILabel = {
        let label = UILabel()
        label.text = Strings.Signup.name()
        label.textColor = AppColors.darkBlue
        label.font = AppFonts.boldFontWithSize(18)
        label.sizeToFit()
        return label
    }()
    
    private let nameInput: UITextField = {
        
        let textField = UITextField()
        textField.attributedPlaceholder = NSAttributedString(string: Strings.Signup.namePlaceholder(),
                                                             attributes: [NSAttributedString.Key.foregroundColor: UIColor.lightGray])
        textField.font = AppFonts.regularFontWithSize(16)
        textField.autocapitalizationType = .none
        textField.borderStyle = .none
        textField.textColor = .black
        
        textField.addTarget(self, action: #selector(SignupView.userEditedText), for: .editingChanged)
        
        return textField
    }()
    
    private let emailLabel: UILabel = {
        let label = UILabel()
        label.text = Strings.Signup.email()
        label.textColor = AppColors.darkBlue
        label.font = AppFonts.boldFontWithSize(18)
        label.sizeToFit()
        return label
    }()
    
    private let emailInput: UITextField = {

        let textField = UITextField()
        textField.attributedPlaceholder = NSAttributedString(string: Strings.Signup.emailPlaceholder(),
                                                             attributes: [NSAttributedString.Key.foregroundColor: UIColor.lightGray])
        textField.font = AppFonts.regularFontWithSize(16)
        textField.autocapitalizationType = .none
        textField.borderStyle = .none
        textField.textColor = .black
        textField.keyboardType = .emailAddress
        
        textField.addTarget(self, action: #selector(SignupView.userEditedText), for: .editingChanged)
        
        return textField
    }()
    
    private let passwordLabel: UILabel = {
        let label = UILabel()
        label.text = Strings.Signup.password()
        label.textColor = AppColors.darkBlue
        label.font = AppFonts.boldFontWithSize(18)
        label.sizeToFit()
        return label
    }()
    
    private let passwordInput: UITextField = {
        
        let textField = UITextField()
        textField.textContentType = .password
        textField.attributedPlaceholder = NSAttributedString(string: Strings.Signup.passwordPlaceholder(),
                                                             attributes: [NSAttributedString.Key.foregroundColor: UIColor.lightGray])
        textField.font = AppFonts.regularFontWithSize(16)
        textField.isSecureTextEntry = true
        textField.borderStyle = .none
        textField.textColor = .black
        
        textField.addTarget(self, action: #selector(SignupView.userEditedText), for: .editingChanged)
        
        return textField
    }()
    
    private let confirmPasswordLabel: UILabel = {
        let label = UILabel()
        label.text = Strings.Signup.confirmPassword()
        label.textColor = AppColors.darkBlue
        label.font = AppFonts.boldFontWithSize(18)
        label.sizeToFit()
        return label
    }()
    
    private let confirmPasswordInput: UITextField = {
        
        let textField = UITextField()
        textField.textContentType = .password
        textField.attributedPlaceholder = NSAttributedString(string: Strings.Signup.confirmPasswordPlaceholder(),
                                                             attributes: [NSAttributedString.Key.foregroundColor: UIColor.lightGray])
        textField.font = AppFonts.regularFontWithSize(16)
        textField.isSecureTextEntry = true
        textField.borderStyle = .none
        textField.textColor = .black
        
        textField.addTarget(self, action: #selector(SignupView.userEditedText), for: .editingChanged)
        
        return textField
    }()
    
    private let signupButton: ButtonWithActivity = {
        let button = ButtonWithActivity()
        button.setTitle(Strings.Signup.signup(), for: .normal)
        button.setTitleColor(.white, for: .normal)
        button.backgroundColor = AppColors.darkBlue
        button.layer.cornerRadius = 8
        
        button.addTarget(self, action: #selector(SignupView.didPressSignup), for: .touchUpInside)
        return button
    }()
    
    private let backToLoginLabel: UIView = {
        
        let label = UILabel(frame: CGRect.zero)
        label.text = Strings.Signup.haveAccount()
        label.textColor = AppColors.almostBlack
        label.font = AppFonts.regularFontWithSize(14)
        label.sizeToFit()
        
        return label
    }()
    
    private let backToLoginButton: UIButton = {
        let button = UIButton()
        button.setTitle(Strings.Signup.login(), for: .normal)
        button.setTitleColor(AppColors.almostBlack, for: .normal)
        button.titleLabel?.font = AppFonts.boldFontWithSize(14)
        
        button.backgroundColor = .clear
        button.layer.cornerRadius = 8
        
        button.addTarget(self, action: #selector(SignupView.didPressBackToLogin), for: .touchUpInside)
        button.sizeToFit()
        return button
    }()
    
    private let errorLabel: UILabel = {
        let label = UILabel(frame: CGRect.zero)
        label.textColor = AppColors.accentRed
        label.font = AppFonts.boldFontWithSize(16)
        label.contentMode = .center
        label.textAlignment = .center
        
        return label
    }()
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        
        var currentYOffset: CGFloat = 60
        let holder = UIView(frame: CGRect(x: 0, y: 0, width: frame.width, height: frame.height))
        holder.backgroundColor = .white
        
        
        titleLabel.frame.origin.y = currentYOffset
        titleLabel.center.x = frame.width / 2
        holder.addSubview(titleLabel)
        currentYOffset += titleLabel.frame.height + Constants.rowSpacing * 2
        
        
        nameLabel.frame.origin.x = Constants.leftMargin
        nameLabel.frame.origin.y = currentYOffset
        holder.addSubview(nameLabel)
        currentYOffset += nameLabel.frame.height + Constants.labelSpacing
        
        
        nameInput.frame = CGRect(x: Constants.leftMargin,
                                 y: currentYOffset,
                                 width: frame.width - 2 * Constants.leftMargin,
                                 height: 40)
        nameInput.delegate = self
        AppInterfaceFormatter.addUnderline(toTextField: nameInput)
        holder.addSubview(nameInput)
        currentYOffset += nameInput.frame.height + Constants.rowSpacing
        
        
        emailLabel.frame.origin.x = Constants.leftMargin
        emailLabel.frame.origin.y = currentYOffset
        holder.addSubview(emailLabel)
        currentYOffset += emailLabel.frame.height + Constants.labelSpacing
        
        emailInput.frame = CGRect(x: Constants.leftMargin,
                                  y: currentYOffset,
                                  width: frame.width - 2 * Constants.leftMargin,
                                  height: 40)
        emailInput.delegate = self
        AppInterfaceFormatter.addUnderline(toTextField: emailInput)
        holder.addSubview(emailInput)
        currentYOffset += emailInput.frame.height + Constants.rowSpacing

        passwordLabel.frame.origin.x = Constants.leftMargin
        passwordLabel.frame.origin.y = currentYOffset
        holder.addSubview(passwordLabel)
        currentYOffset += passwordLabel.frame.height + Constants.labelSpacing
        
        passwordInput.frame = CGRect(x: Constants.leftMargin,
                                     y: currentYOffset,
                                     width: frame.width - 2 * Constants.leftMargin,
                                     height: 40)
        passwordInput.delegate = self
        AppInterfaceFormatter.addUnderline(toTextField: passwordInput)
        holder.addSubview(passwordInput)
        currentYOffset += passwordInput.frame.height + Constants.rowSpacing
        
        
        confirmPasswordLabel.frame.origin.x = Constants.leftMargin
        confirmPasswordLabel.frame.origin.y = currentYOffset
        holder.addSubview(confirmPasswordLabel)
        currentYOffset += confirmPasswordLabel.frame.height + Constants.labelSpacing
        
        confirmPasswordInput.frame = CGRect(x: Constants.leftMargin,
                                     y: currentYOffset,
                                     width: frame.width - 2 * Constants.leftMargin,
                                     height: 40)
        confirmPasswordInput.delegate = self
        AppInterfaceFormatter.addUnderline(toTextField: confirmPasswordInput)
        holder.addSubview(confirmPasswordInput)
        currentYOffset += confirmPasswordInput.frame.height + 3 * Constants.rowSpacing
        
        errorLabel.frame = CGRect(x: 0,
                                  y: currentYOffset,
                                  width: frame.width,
                                  height: 40)
        holder.addSubview(errorLabel)
        errorLabel.alpha = 0
        
        signupButton.frame = CGRect(x: Constants.leftMargin * 2,
                                   y: currentYOffset,
                                   width: frame.width - 4 * Constants.leftMargin,
                                   height: 40)
        holder.addSubview(signupButton)
        currentYOffset += signupButton.frame.height + Constants.rowSpacing / 2
        
        
        let backToLogin = backToLoginLabel.frame.width + backToLoginButton.frame.width + 5
        
        backToLoginLabel.frame = CGRect(x: (frame.width - backToLogin) / 2,
                                   y: currentYOffset,
                                   width: backToLoginLabel.frame.width,
                                   height: backToLoginLabel.frame.height)
        holder.addSubview(backToLoginLabel)
        
        backToLoginButton.frame = CGRect(x: backToLoginLabel.frame.origin.x + backToLoginLabel.frame.width + 5,
                                    y: currentYOffset,
                                    width: backToLoginButton.frame.width,
                                    height: backToLoginButton.frame.height)
        backToLoginLabel.center.y = backToLoginButton.center.y
        holder.addSubview(backToLoginButton)

        addSubview(holder)
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    // MARK: - Methods
    
    func showError(withText: String) {
        if !isShowingError {
            isShowingError = true
            self.errorLabel.text = withText
            UIView.animate(withDuration: 0.3) { [unowned self] in
                self.signupButton.frame = self.signupButton.frame.offsetBy(dx: 0, dy: 50)
                self.backToLoginLabel.frame = self.backToLoginLabel.frame.offsetBy(dx: 0, dy: 50)
                self.backToLoginButton.frame = self.backToLoginButton.frame.offsetBy(dx: 0, dy: 50)
                self.errorLabel.alpha = 1
            }
        }
    }
    
    func stopShowingError() {
        if isShowingError {
            isShowingError = false
            UIView.animate(withDuration: 0.3) { [unowned self] in
                self.signupButton.frame = self.signupButton.frame.offsetBy(dx: 0, dy: -50)
                self.backToLoginLabel.frame = self.backToLoginLabel.frame.offsetBy(dx: 0, dy: -50)
                self.backToLoginButton.frame = self.backToLoginButton.frame.offsetBy(dx: 0, dy: -50)
                self.errorLabel.alpha = 0
            }
        }
    }
    
    func clearInputFields() {
        nameInput.text = ""
        emailInput.text = ""
        passwordInput.text = ""
        confirmPasswordInput.text = ""
    }
    
    func setButtonLoading(isLoading loading: Bool) {
        loading ? signupButton.showLoading() : signupButton.hideLoading()
    }
    
    // MARK: - Private Methods

    @objc private func didPressSignup() {
        let name = nameInput.text!
        let email = emailInput.text!
        let password = passwordInput.text!
        let passwordConfirm = confirmPasswordInput.text!
        
        nameInput.resignFirstResponder()
        emailInput.resignFirstResponder()
        passwordInput.resignFirstResponder()
        confirmPasswordInput.resignFirstResponder()
        
        guard !name.isEmpty, !email.isEmpty, !password.isEmpty, !passwordConfirm.isEmpty else {
            showError(withText: Strings.Errors.Signup.allFieldsNeeded())
            return
        }
        
        guard EmailUtils.isValidEmailFormat(email) else {
            showError(withText: Strings.Errors.Signup.invalidEmail())
            return
        }
        
        guard password == passwordConfirm else {
            showError(withText: Strings.Errors.Signup.passNotMatch())
            return
        }
        
        signupButton.showLoading()

        delegate?.signupViewDidRequestSignUp(self, withName: name, withEmail: email, withPassword: password)
    }
    
    @objc private func userEditedText() {
        self.stopShowingError()
    }
    
    @objc private func didPressBackToLogin() {
        nameInput.resignFirstResponder()
        emailInput.resignFirstResponder()
        passwordInput.resignFirstResponder()
        confirmPasswordInput.resignFirstResponder()
        delegate?.signupViewDidRequestLoginPage(self)
    }
}

extension SignupView: UITextFieldDelegate {
    func textFieldShouldReturn(_ textField: UITextField) -> Bool {
        textField.resignFirstResponder()
        return true
    }
}
