//
//  DonationBookingViewController.swift
//  EasyHelp
//
//  Created by Stefan Georgescu on 25/05/2019.
//  Copyright © 2019 EasyHelp. All rights reserved.
//

import UIKit

public enum DonationBookingControllerStyle {
    case book, view
}

class DonationBookingViewController: UIViewController {
    
    var donationBookingView: DonationBookingView
    var style: DonationBookingControllerStyle
    
    init(donationBooking: DonationBooking, style: DonationBookingControllerStyle) {
        self.style = style
        self.donationBookingView = DonationBookingView(frame: CGRect(x: 0,
                                                                     y: AppScreenUtils.screenStatusBarAndHeaderHeight,
                                                                     width: UIScreen.main.bounds.width,
                                                                     height: UIScreen.main.bounds.height - AppScreenUtils.screenStatusBarAndHeaderHeight),
                                                       donationBooking: donationBooking,
                                                       style: style)
        super.init(nibName: nil, bundle: nil)
        
        if style == .view {
            let closeBtn = AppInterfaceFormatter.navigationBarButtonWithIcon(UIImage(named: "close_icon")!, highlightIcon: nil)
            closeBtn.addTarget(self, action: #selector(DonationBookingViewController.onClose(_:)), for: UIControl.Event.touchUpInside)
            self.navigationItem.rightBarButtonItem = UIBarButtonItem(customView: closeBtn)
        }
        
        self.donationBookingView.delegate = self
        self.title = "Booking Summary"
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override func viewDidLoad() {
        self.view = UIView(frame: UIScreen.main.bounds)
        self.view.backgroundColor = AppColors.white
        self.view.addSubview(donationBookingView)
    }
    
    @objc fileprivate func onClose(_ sender: UIButton) {
        self.navigationController?.dismiss(animated: true, completion: nil)
    }
}

extension DonationBookingViewController: DonationBookingViewDelegate {
    func donationBookingViewDidRequestCancelBooking(_ sender: DonationBookingView, donationBooking: DonationBooking) {
        AppServices.donorService.cancelBooking(donationBooking) { (error) in
            if let error = error {
                // handle error
            } else {
                NotificationCenter.default.post(name: .GoBackToLanding, object: nil)
            }
        }
    }
    
    func donationBookingViewDidRequestBook(_ sender: DonationBookingView, donationBooking: DonationBooking) {
        AppServices.donorService.bookDonation(donationBooking, callback: { (id, error) in
            if let error = error {
                // handle error
            } else if let id = id {
                let bookDate = donationBooking.date
                var notifComponents = DateComponents()
                notifComponents.year = Calendar.current.component(.year, from: bookDate)
                notifComponents.month = Calendar.current.component(.month, from: bookDate)
                notifComponents.day = Calendar.current.component(.day, from: bookDate) - 1
                notifComponents.hour = 20
                notifComponents.minute = 0
                notifComponents.second = 0
                notifComponents.timeZone = NSTimeZone.local
                let notifDate = Calendar.current.date(from: notifComponents)!
                PushNotifUtils.sharedInstance.scheduleLocalNotification(onDate: notifDate, withMessage: "Please check your donation form to speed up the donation tomorrow.")
                
                donationBooking.id = id
                NotificationCenter.default.post(name: .GoBackToLanding, object: donationBooking)
            }
        })
    }
    
    func donationBookingViewDidRequestForm(_ sender: DonationBookingView) {
        let vc = UINavigationController(rootViewController: DonorFormFillViewController(source: .booking))
        self.navigationController?.present(vc, animated: true, completion: nil)
    }
}

