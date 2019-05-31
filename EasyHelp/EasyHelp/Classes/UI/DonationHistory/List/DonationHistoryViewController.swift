//
//  DonationHistoryViewController.swift
//  EasyHelp
//
//  Created by Stefan Georgescu on 22/03/2019.
//  Copyright © 2019 EasyHelp. All rights reserved.
//

import UIKit

class DonationHistoryViewController: UIViewController {
    
    private enum DesignType {
        case single, double
    }
    
    let cellIdentifier = "donation-history-cell"
    let tableView: UITableView
    var donations: [Donation] = []
    private var design: DesignType = .single
    
    init() {
        tableView = UITableView(frame: UIScreen.main.bounds, style: .grouped)
        super.init(nibName: nil, bundle: nil)
        
        tableView.delegate = self
        tableView.dataSource = self
        
        tableView.backgroundView = LoadingView(frame: tableView.bounds)
        tableView.register(DonationHistoryCell.self, forCellReuseIdentifier: cellIdentifier)
        tableView.separatorStyle = .none
        
        self.title = "Donation History"
        
        AppServices.donorService.getDonationHistory { (donations, error) in
            if let donations = donations {
                if donations.isEmpty {
                    self.tableView.backgroundView = TitleMessageView(frame: self.tableView.bounds, title: "You have no donations yet")
                } else {
                    let view = UIView(frame: self.tableView.bounds)
                    view.backgroundColor = AppColors.white
                    self.tableView.backgroundView = view
                    self.donations = donations
                    self.tableView.reloadData()
                    if let firstDonation = donations.first, donations.count > 1, firstDonation.testResults == nil {
                        self.design = .double
                    }
                }
            } else if let error = error {
                let ev = ErrorView(frame: UIScreen.main.bounds, errorMessage: error.myErrorInfo)
                ev.delegate = self
                self.view = ev
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
        return design == .single ? 1 : 2
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        switch design {
        case .single:
            return donations.count
        case .double:
            if section == 0 {
                return 1
            }
            return donations.count - 1
        }
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: cellIdentifier, for: indexPath) as! DonationHistoryCell
        
        switch design {
        case .single:
            cell.syncView(donation: donations[indexPath.row])
        case .double:
            if indexPath.section == 0 {
                cell.syncView(donation: donations[0])
            } else {
                cell.syncView(donation: donations[indexPath.row + 1])
            }
        }
        
        return cell
    }
}

extension DonationHistoryViewController: UITableViewDelegate {
    func tableView(_ tableView: UITableView, viewForHeaderInSection section: Int) -> UIView? {
        switch design {
        case .single:
            return nil
        case .double:
            let view = UIView(frame: CGRect(x: 0, y: 0, width: tableView.frame.width, height: 30))
            let label = UILabel()
            label.font = AppFonts.boldFontWithSize(18)
            label.textColor = AppColors.almostBlack
            if section == 0 {
                label.text = "Recent Donation"
            } else {
                label.text = "Previous Donations"
            }
            label.sizeToFit()
            label.frame.origin = CGPoint(x: 10, y: (30 - label.frame.height) / 2 + 5)
            view.addSubview(label)
            view.backgroundColor = .clear
            return view
        }
    }
    
    func tableView(_ tableView: UITableView, heightForHeaderInSection section: Int) -> CGFloat {
        return design == .double ? 30 : 0
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 120
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        var vc: UIViewController
        
        switch design {
        case .single:
            vc = DonationDetailsViewController(donation: donations[indexPath.row])
        case .double:
            if indexPath.section == 0 {
                vc = DonationDetailsViewController(donation: donations[0])
            } else {
                vc = DonationDetailsViewController(donation: donations[indexPath.row + 1])
            }
        }
        
        self.navigationController?.pushViewController(vc, animated: true)
    }
}

extension DonationHistoryViewController: ErrorViewDelegate {
    func errorViewDidRequestTryAgain(_ errorView: ErrorView) {
        
    }
}
