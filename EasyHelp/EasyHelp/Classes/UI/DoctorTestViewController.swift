//
//  DoctorTestViewController.swift
//  EasyHelp
//
//  Created by Georgescu Stefan on 16/09/2018.
//  Copyright © 2018 EasyHelp. All rights reserved.
//


import UIKit

class DoctorTestViewController: UIViewController, UITableViewDelegate, UITableViewDataSource  {
    
    fileprivate let doctorService = DefaultDoctorService()
    fileprivate var tableView = UITableView(frame: UIScreen.main.bounds)
    fileprivate let cellReuseID = "doctor-list-cell"
    var doctors: [Doctor] = []
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        tableView.dataSource = self
        tableView.delegate = self
        tableView.register(UITableViewCell.self, forCellReuseIdentifier: cellReuseID)
        
        doctorService.getAllDoctors { [unowned self] (doctors: [Doctor]) in
            self.doctors = doctors
            self.tableView.reloadData()
        }
        
        view.addSubview(tableView)
        // Do any additional setup after loading the view, typically from a nib.
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    func numberOfSections(in tableView: UITableView) -> Int {
        return 1
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 80
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return doctors.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: cellReuseID, for: indexPath)
        
        cell.frame = cell.bounds
        let doctorLabel = UILabel(frame: cell.frame)
        doctorLabel.text = doctors[indexPath.row].getStringRep()
        cell.addSubview(doctorLabel)
        
        return cell
    }
}

