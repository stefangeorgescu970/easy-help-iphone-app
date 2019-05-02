//
//  DonorFormFillViewController.swift
//  EasyHelp
//
//  Created by Stefan Georgescu on 30/04/2019.
//  Copyright © 2019 EasyHelp. All rights reserved.
//

import UIKit

enum DonorFormSource {
    case onboarding, profile, booking
}

class DonorFormFillViewController: UIViewController {
    private let cellReuseIdentifier = "donor-form-cell"
    private var tableView: UITableView
    private let dataSource = DonorFormFillDataSource()
    private let source: DonorFormSource
    
    private let addButton: ButtonWithActivity = {
        let button = ButtonWithActivity()
        button.setTitle("Save", for: .normal)
        button.setTitleColor(.white, for: .normal)
        button.backgroundColor = AppColors.appRed
        button.layer.cornerRadius = 8
        
        button.addTarget(self, action: #selector(DonorFormFillViewController.didPressAdd(_:)), for: .touchUpInside)
        
        return button
    }()
    
    init(source: DonorFormSource) {
        self.tableView = UITableView(frame: UIScreen.main.bounds)
        self.tableView.separatorStyle = .none
        self.tableView.rowHeight = 150
        self.source = source
        
        super.init(nibName: nil, bundle: nil)
        
        self.title = "Donation Form"
        
        self.tableView.dataSource = dataSource
        self.tableView.register(DonorFormFillCell.self, forCellReuseIdentifier: cellReuseIdentifier)
        
        let closeBtn = AppInterfaceFormatter.navigationBarButtonWithIcon(UIImage(named: "close_icon")!, highlightIcon: nil)
        closeBtn.addTarget(self, action: #selector(DonorFormFillViewController.onClose(_:)), for: UIControl.Event.touchUpInside)
        self.navigationItem.rightBarButtonItem = UIBarButtonItem(customView: closeBtn)
        
        let view = UIView(frame: CGRect(origin: CGPoint.zero, size: CGSize(width: tableView.bounds.width, height: 60)))
        
        addButton.frame = CGRect(x: 20, y: 10, width: tableView.bounds.width - 40, height: 40)
        view.addSubview(addButton)
        
        self.tableView.tableFooterView = view
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
    
    @objc func didPressAdd(_ sender: UIButton) {
        guard dataSource.allFieldsValid() else { return }

        let form = dataSource.getDonationForm()
        AppServices.donorService.locallyPersistDonationForm(form)
    
        switch source {
        case .profile:
            // TODO: - check if there is a current booking and forward to server if so
            self.onClose(sender)
        case .onboarding:
            MainFlowManager.goToLandingPage()
        case .booking:
            AppServices.donorService.sendDonationFormToServer(form) { (error) in
                // TODO: - check for error
                self.onClose(sender)
            }
        }
    }
}
