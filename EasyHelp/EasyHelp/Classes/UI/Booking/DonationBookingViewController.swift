//
//  DonationBookingViewController.swift
//  EasyHelp
//
//  Created by Stefan Georgescu on 25/05/2019.
//  Copyright © 2019 EasyHelp. All rights reserved.
//

import UIKit

class DonationBookingViewController: UIViewController {
    
    var donationBookingView: DonationBookingView
    
    init(donationBooking: DonationBooking) {
        self.donationBookingView = DonationBookingView(frame: CGRect(x: 0, y: AppScreenUtils.screenStatusBarAndHeaderHeight, width: UIScreen.main.bounds.width, height: UIScreen.main.bounds.height - AppScreenUtils.screenStatusBarAndHeaderHeight), donationBooking: donationBooking)
        super.init(nibName: nil, bundle: nil)
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
}

extension DonationBookingViewController: DonationBookingViewDelegate {
    func donationBookingViewDidRequestBook(_ sender: DonationBookingView, donationBooking: DonationBooking) {
        AppServices.donorService.bookDonation(donationBooking, callback: { (error) in
            if let error = error {
                // handle error
            } else {
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
                
                NotificationCenter.default.post(name: .GoBackToLanding, object: donationBooking)
            }
        })
    }
    
    func donationBookingViewDidRequestForm(_ sender: DonationBookingView) {
        let vc = UINavigationController(rootViewController: DonorFormFillViewController(source: .booking))
        self.navigationController?.present(vc, animated: true, completion: nil)
    }
}

