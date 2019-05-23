//
//  DonationHistoryViewController.swift
//  EasyHelp
//
//  Created by Stefan Georgescu on 22/03/2019.
//  Copyright © 2019 EasyHelp. All rights reserved.
//

import UIKit

class DonationHistoryViewController: UIViewController {
    
    let cellIdentifier = "donation-history-cell"
    let tableView: UITableView
    var donations: [Donation] = []
    
    init() {
        tableView = UITableView(frame: UIScreen.main.bounds)
        super.init(nibName: nil, bundle: nil)
        
        tableView.delegate = self
        tableView.dataSource = self
        
        tableView.backgroundView = LoadingView(frame: tableView.bounds)
        tableView.register(DonationHistoryCell.self, forCellReuseIdentifier: cellIdentifier)
        tableView.separatorStyle = .none
        
        self.title = "Donation History"
        
        AppServices.donorService.getDonationHistory { (donations, error) in
            if let donations = donations {
                self.tableView.backgroundView = nil
                self.donations = donations
                self.tableView.reloadData()
            } else if let error = error {
                
            }
        }
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override func viewDidLoad() {
        self.edgesForExtendedLayout = []
        self.view = tableView
    }
}

extension DonationHistoryViewController: UITableViewDataSource {
    func numberOfSections(in tableView: UITableView) -> Int {
        return 1
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return donations.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: cellIdentifier, for: indexPath) as! DonationHistoryCell
        
        cell.syncView(donation: donations[indexPath.row])
        
        return cell
    }
}

extension DonationHistoryViewController: UITableViewDelegate {
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 120
    }
}
