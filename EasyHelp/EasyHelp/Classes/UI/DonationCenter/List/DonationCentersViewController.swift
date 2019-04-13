//
//  DonationCentersViewController.swift
//  EasyHelp
//
//  Created by Stefan Georgescu on 12/04/2019.
//  Copyright © 2019 EasyHelp. All rights reserved.
//

import UIKit

class DonationCentersViewController: UIViewController {
    private let cellReuseIdentifier = "donation-center-cell"
    private var tableView: UITableView
    private var donationCenters: [DonationCenter] = []
    
    init() {
        self.tableView = UITableView(frame: UIScreen.main.bounds)
        self.tableView.separatorStyle = .none
        
        super.init(nibName: nil, bundle: nil)
        
        self.title = "Donation Centers"
        
        self.tableView.delegate = self
        self.tableView.dataSource = self
        self.tableView.register(DonationCenterCell.self, forCellReuseIdentifier: cellReuseIdentifier)
        
        self.tableView.backgroundView = LoadingView(frame: tableView.bounds)
        
        let closeBtn = AppInterfaceFormatter.navigationBarButtonWithIcon(UIImage(named: "close_icon")!, highlightIcon: nil)
        closeBtn.addTarget(self, action: #selector(DonationCentersViewController.onClose(_:)), for: UIControl.Event.touchUpInside)
        self.navigationItem.rightBarButtonItem = UIBarButtonItem(customView: closeBtn)
        
        AppServices.donationCenterService.getDonationCenters { (donationCenters, error) in
            if let donationCenters = donationCenters {
                self.donationCenters.append(contentsOf: donationCenters)
                self.syncView()
            } else {
                // handle error
            }
        }
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override func viewDidLoad() {
        self.view = tableView
    }
    
    func syncView() {
        if tableView.dataSource?.numberOfSections!(in: tableView) == 0 {
//            tableView.backgroundView = TitleMessageView(frame: tableView.bounds, title: Strings.CourseDetails.noStudents())
        } else {
            tableView.backgroundView = nil
            tableView.reloadData()
        }
    }
    
    @objc func onClose(_ sender: UIButton) {
        self.navigationController?.dismiss(animated: true, completion: nil)
    }
}

extension DonationCentersViewController: UITableViewDataSource {
    func numberOfSections(in tableView: UITableView) -> Int {
        return 1
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return donationCenters.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: cellReuseIdentifier, for: indexPath) as! DonationCenterCell
        
        cell.syncView(donationCenter: self.donationCenters[indexPath.row])
        cell.showSeparator(indexPath.row != self.donationCenters.count)
        
        return cell
    }
}

extension DonationCentersViewController: UITableViewDelegate {
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 100
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        let dc = donationCenters[indexPath.row]
        self.navigationController?.pushViewController(DonationCenterMainViewController(donationCenter: dc), animated: true)
        tableView.deselectRow(at: indexPath, animated: true)
    }
}
