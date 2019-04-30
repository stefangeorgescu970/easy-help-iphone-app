//
//  DonorFormFillViewController.swift
//  EasyHelp
//
//  Created by Stefan Georgescu on 30/04/2019.
//  Copyright © 2019 EasyHelp. All rights reserved.
//

import UIKit

class DonorFormFillViewController: UIViewController {
    private let cellReuseIdentifier = "donor-form-cell"
    private var tableView: UITableView
    private let dataSource = DonorFormFillDataSource()
    
    init() {
        self.tableView = UITableView(frame: UIScreen.main.bounds)
        self.tableView.separatorStyle = .none
        self.tableView.rowHeight = UITableView.automaticDimension
        self.tableView.estimatedRowHeight = 200
        
        super.init(nibName: nil, bundle: nil)
        
        self.title = "Donation Form"
        
        self.tableView.delegate = self
        self.tableView.dataSource = dataSource
        self.tableView.register(DonorFormFillCell.self, forCellReuseIdentifier: cellReuseIdentifier)
        
        let closeBtn = AppInterfaceFormatter.navigationBarButtonWithIcon(UIImage(named: "close_icon")!, highlightIcon: nil)
        closeBtn.addTarget(self, action: #selector(DonorFormFillViewController.onClose(_:)), for: UIControl.Event.touchUpInside)
        self.navigationItem.rightBarButtonItem = UIBarButtonItem(customView: closeBtn)
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override func viewDidLoad() {
        self.view = tableView
    }
    
    @objc func onClose(_ sender: UIButton) {
        self.navigationController?.dismiss(animated: true, completion: nil)
    }
}

extension DonorFormFillViewController: UITableViewDelegate {

}
