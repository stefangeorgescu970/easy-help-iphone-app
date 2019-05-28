//
//  DonationCenterMainViewController.swift
//  EasyHelp
//
//  Created by Stefan Georgescu on 13/04/2019.
//  Copyright © 2019 EasyHelp. All rights reserved.
//

import UIKit
import MapKit

class DonationCenterMainViewController: UIViewController {
    private let cellReuseIdentifier = "available-hour-cell"
    private var tableView: UITableView
    private var infoView: DonationCenterInfoView
    private var availableDates: [AvailableDate] = []
    private var selectedDateIndex: Int = 0
    private var donationCenter: DonationCenter
    private var ssn: String? = nil
    
    init(donationCenter: DonationCenter) {
        self.donationCenter = donationCenter
        self.infoView = DonationCenterInfoView(frame: CGRect(x: 0, y: AppScreenUtils.screenStatusBarAndHeaderHeight, width: UIScreen.main.bounds.width, height: UIScreen.main.bounds.height - 300 - AppScreenUtils.screenStatusBarAndHeaderHeight), donationCenter: donationCenter)
        self.tableView = UITableView(frame: CGRect(x: 0, y: UIScreen.main.bounds.height - 300, width: UIScreen.main.bounds.width, height: 300))
        self.tableView.separatorStyle = .none

        self.tableView.register(UITableViewCell.self, forCellReuseIdentifier: cellReuseIdentifier)
        super.init(nibName: nil, bundle: nil)
        
        self.infoView.delegate = self
        self.tableView.dataSource = self
        self.tableView.delegate = self
        
        AppServices.donorService.getAvailableHours(forDonationCenter: donationCenter) { (availableDates, error) in
            if let availableDates = availableDates {
                self.availableDates.append(contentsOf: availableDates)
                self.tableView.reloadData()
                self.infoView.syncView(forAvailableDates: self.availableDates)
            } else {
                // handle error
            }
        }
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.view = UIView(frame: UIScreen.main.bounds)
        self.view.backgroundColor = AppColors.white
        self.view.addSubview(infoView)
        self.view.addSubview(tableView)
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}

extension DonationCenterMainViewController: DonationCenterInfoViewDelegate {
    func donationCenterInfoViewSetSSN(_sender: DonationCenterInfoView, ssn: String) {
        self.ssn = ssn
    }
    
    func donationCenterInfoViewDidTapDate(_ sender: DonationCenterInfoView, withIndex index: Int) {
        self.selectedDateIndex = index
        self.tableView.reloadData()
    }
    
    func donationCenterInfoViewDidRequestViewMap(_ sender: DonationCenterInfoView, forDonationCenter donationCenter: DonationCenter) {
        let regionDistance:CLLocationDistance = 10000
        let coordinates = CLLocationCoordinate2DMake(donationCenter.lat, donationCenter.long)
        let regionSpan = MKCoordinateRegion(center: coordinates, latitudinalMeters: regionDistance, longitudinalMeters: regionDistance)
        let options = [
            MKLaunchOptionsMapCenterKey: NSValue(mkCoordinate: regionSpan.center),
            MKLaunchOptionsMapSpanKey: NSValue(mkCoordinateSpan: regionSpan.span)
        ]
        let placemark = MKPlacemark(coordinate: coordinates, addressDictionary: nil)
        let mapItem = MKMapItem(placemark: placemark)
        mapItem.name = donationCenter.name
        mapItem.openInMaps(launchOptions: options)
    }
}

extension DonationCenterMainViewController: UITableViewDelegate {
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        let date = availableDates[selectedDateIndex].availableHours[indexPath.row]
        let booking = DonationBooking(date: date, donationCenter: donationCenter)
        booking.patientSSN = ssn
        
        let vc = DonationBookingViewController(donationBooking: booking)
        self.navigationController?.pushViewController(vc, animated: true)
    }
}

extension DonationCenterMainViewController: UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        if availableDates.count == 0 {
            return 0
        }
        
        return availableDates[selectedDateIndex].availableHours.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: cellReuseIdentifier, for: indexPath)
        
        cell.textLabel?.text = DateUtils.getHourIntervalString(fromDate: availableDates[selectedDateIndex].availableHours[indexPath.row])
        cell.textLabel?.frame.origin = CGPoint(x: 20, y: cell.textLabel!.frame.origin.y)
        
        return cell
    }
    
    func numberOfSections(in tableView: UITableView) -> Int {
        return 1
    }
}
