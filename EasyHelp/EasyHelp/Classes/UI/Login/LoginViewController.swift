//
//  LoginViewController.swift
//  AcademicInfo
//
//  Created by Stefan Georgescu on 10/11/2018.
//  Copyright © 2018 Stefan Georgescu. All rights reserved.
//

import UIKit

class LoginViewController: UIViewController {
    
    private var loginView: LoginView
    private var signupView: SignupView
    private var scrollView: UIScrollView
    
    init(frame: CGRect) {
        loginView = LoginView(frame: frame)
        signupView = SignupView(frame: CGRect(x: 0, y: frame.height, width: frame.width, height: frame.height))
        
        scrollView = UIScrollView(frame: frame)
        scrollView.contentSize = CGSize(width: frame.width, height: frame.height * 2)
        scrollView.contentInsetAdjustmentBehavior = .never
        scrollView.isScrollEnabled = false
        scrollView.showsVerticalScrollIndicator = false
        
        scrollView.addSubview(loginView)
        scrollView.addSubview(signupView)
        
        super.init(nibName: nil, bundle: nil)
        
        loginView.delegate = self
        signupView.delegate = self
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override func loadView() {
        self.view = scrollView
    }
    
    func setUserAndPass(user: String, pass: String) {
        loginView.setUserAndPass(user: user, pass: pass)
    }
}

extension LoginViewController: LoginViewDelegate {
    func loginView(_ loginView: LoginView, didRequestLogin withEmail: String, withPassword: String) {
        
        AppServices.profileService.loginUser(withEmail: withEmail, andPassword: withPassword) { (profileData: DonorProfileData?, error: NSError?) in
            if let profileData = profileData {
                loginView.setButtonLoading(isLoading: false)
                loginView.stopShowingError()
                AppServices.profileService.saveCurrentUser(profileData)
                MainFlowManager.redirectAfterLogin()
            } else {
                loginView.setButtonLoading(isLoading: false)
                if let errorDescription = error?.myErrorInfo {
                    loginView.showError(withText: errorDescription)
                } else {
                    loginView.showError(withText: Strings.Errors.generic())
                }
            }
        }
    }
    
    func loginViewRequestedSignup(_ loginVieW: LoginView) {
        scrollView.scrollRectToVisible(signupView.frame, animated: true)
    }
}

extension LoginViewController: SignupViewDelegate {
    func signupViewDidRequestSignUp(_ signupView: SignupView, withName name: String, withEmail email: String, withPassword password: String) {
        AppServices.profileService.signupUser(withName: name, withEmail: email, withPassword: password) { [unowned self] (error: NSError?) in
            if let error = error {
                signupView.setButtonLoading(isLoading: false)
                signupView.showError(withText: error.myErrorInfo)
            } else {
                signupView.setButtonLoading(isLoading: false)
                self.signupView.stopShowingError()
                self.signupView.clearInputFields()
                self.loginView.setEmailInput(value: email)
                self.loginView.showInfo(withText: Strings.Login.validateAccountFirst())
                self.signupViewDidRequestLoginPage(signupView)
            }
        }
    }
    
    func signupViewDidRequestLoginPage(_ signupView: SignupView) {
        scrollView.scrollRectToVisible(loginView.frame, animated: true)
    }
}
