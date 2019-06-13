//
//  DonationDetailsCasesController.swift
//  EasyHelp Mock
//
//  Created by Stefan Georgescu on 10/06/2019.
//  Copyright © 2019 EasyHelp. All rights reserved.
//

import UIKit

class DonationDetailsCasesController: UIViewController {
    
    private typealias AccIds = TestStrings.Mocks.DonationDetailsCasesController
    
    let tableView: UITableView
    let cellIdentifier = "cell-id"
    
    let hasResultsSwitch = UISwitch()
    let badResultsSwitch = UISwitch()
    
    init() {
        self.tableView = UITableView(frame: UIScreen.main.bounds)
        self.tableView.register(UITableViewCell.self, forCellReuseIdentifier: cellIdentifier)
        self.tableView.accessibilityIdentifier = AccIds.view
        
        super.init(nibName: nil, bundle: nil)
        
        self.title = "Donation Details Cases"
        
        self.tableView.delegate = self
        self.tableView.dataSource = self
        
        hasResultsSwitch.accessibilityIdentifier = AccIds.hasResultsSwitch
        badResultsSwitch.accessibilityIdentifier = AccIds.areResultsBadSwitch
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override func loadView() {
        self.view = tableView
    }
    
    override func viewDidLoad() {
        self.edgesForExtendedLayout = []
    }
}

extension DonationDetailsCasesController: UITableViewDelegate {
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        if indexPath.row == 2 {            
            self.navigationController?.pushViewController(DonationDetailsViewController(donation: MockGlobalData.sharedInstance.defaultDonation(withTestResult: hasResultsSwitch.isOn,
                                                                                                                                                badTestResults: badResultsSwitch.isOn)),
                                                          animated: true)
        }
    }
}

extension DonationDetailsCasesController: UITableViewDataSource {
    func numberOfSections(in tableView: UITableView) -> Int {
        return 1
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return 3
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: cellIdentifier, for: indexPath)
        
        switch indexPath.row {
        case 0:
            cell.textLabel?.text = "Has Good Results"
            cell.accessoryView = hasResultsSwitch
            cell.selectionStyle = .none
        case 1:
            cell.textLabel?.text = "Are Results Bad"
            cell.accessoryView = badResultsSwitch
            cell.selectionStyle = .none
        case 2:
            cell.textLabel?.text = "Show View"
            cell.textLabel?.accessibilityIdentifier = AccIds.showViewCell
        default:
            break
        }
        
        return cell
    }
}

