//
//  MainMocksTableViewController.swift
//  EasyHelp Mock
//
//  Created by Stefan Georgescu on 09/06/2019.
//  Copyright © 2019 EasyHelp. All rights reserved.
//

import UIKit

class MainMocksTableViewController: UIViewController {
    
    let tableView: UITableView
    let cellIdentifier = "cell-id"
    
    init() {
        self.tableView = UITableView(frame: UIScreen.main.bounds)
        self.tableView.register(UITableViewCell.self, forCellReuseIdentifier: cellIdentifier)
        
        super.init(nibName: nil, bundle: nil)
        
        self.title = "Easy Help Mocks"
        
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

extension MainMocksTableViewController: UITableViewDelegate {
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        switch indexPath.row {
        case 0:
            self.navigationController?.pushViewController(MainViewCasesController(), animated: true)
        case 1:
            self.navigationController?.pushViewController(DonationDetailsCasesController(), animated: true)
        default:
            break
        }
    }
}

extension MainMocksTableViewController: UITableViewDataSource {
    func numberOfSections(in tableView: UITableView) -> Int {
        return 1
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return 2
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: cellIdentifier, for: indexPath)
        
        switch indexPath.row {
        case 0:
            cell.textLabel?.text = "Main View Cases"
        case 1:
            cell.textLabel?.text = "Donation Details Cases"
        default:
            break
        }
        
        return cell
    }
}
