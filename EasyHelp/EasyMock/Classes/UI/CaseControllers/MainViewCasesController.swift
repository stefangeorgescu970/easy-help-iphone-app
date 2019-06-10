//
//  MainViewCasesController.swift
//  EasyHelp Mock
//
//  Created by Stefan Georgescu on 10/06/2019.
//  Copyright © 2019 EasyHelp. All rights reserved.
//

import UIKit

class MainViewCasesController: UIViewController {
    
    let tableView: UITableView
    let cellIdentifier = "cell-id"
    
    let hasStreakSwitch = UISwitch()
    let hasLastDonationSwitch = UISwitch()
    let hasBookingSwitch = UISwitch()
    let canHelpSwitch = UISwitch()
    
    init() {
        self.tableView = UITableView(frame: UIScreen.main.bounds)
        self.tableView.register(UITableViewCell.self, forCellReuseIdentifier: cellIdentifier)
        
        super.init(nibName: nil, bundle: nil)
        
        self.title = "Main View Cases"
        
        self.tableView.delegate = self
        self.tableView.dataSource = self
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

extension MainViewCasesController: UITableViewDelegate {
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        if indexPath.row == 4 {
            self.tableView.deselectRow(at: indexPath, animated: false)
            
            MockGlobalData.sharedInstance.summaryHasBooking = hasBookingSwitch.isOn
            MockGlobalData.sharedInstance.summaryHasStreakBegin = hasStreakSwitch.isOn
            MockGlobalData.sharedInstance.summaryHasLastDonation = hasLastDonationSwitch.isOn
            MockGlobalData.sharedInstance.summaryHasCanHelp = canHelpSwitch.isOn
            
            self.navigationController?.pushViewController(MainScreenViewController(), animated: true)
        }
    }
}

extension MainViewCasesController: UITableViewDataSource {
    func numberOfSections(in tableView: UITableView) -> Int {
        return 1
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return 5
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: cellIdentifier, for: indexPath)
        
        switch indexPath.row {
        case 0:
            cell.textLabel?.text = "Has Max Donations"
            cell.accessoryView = hasStreakSwitch
            cell.selectionStyle = .none
        case 1:
            cell.textLabel?.text = "Has Recently Donated"
            cell.accessoryView = hasLastDonationSwitch
            cell.selectionStyle = .none
        case 2:
            cell.textLabel?.text = "Has booking"
            cell.accessoryView = hasBookingSwitch
            cell.selectionStyle = .none
        case 3:
            cell.textLabel?.text = "Can help donors"
            cell.accessoryView = canHelpSwitch
            cell.selectionStyle = .none
        case 4:
            cell.textLabel?.text = "Show View"
        default:
            break
        }
        
        return cell
    }
}
