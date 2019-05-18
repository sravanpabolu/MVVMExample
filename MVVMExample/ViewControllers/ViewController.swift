//
//  ViewController.swift
//  MVVMExample
//
//  Created by Sravan on 06/05/19.
//  Copyright © 2019 Sravan. All rights reserved.
//

import UIKit

class ViewController: UIViewController {

    var viewModel: MainViewModel = MainViewModel()
    var tableView: UITableView = {
        var tableView = UITableView()
//        tableView.frame = CGRect(x: 10, y: 10, width: 100, height: 500)
        tableView.translatesAutoresizingMaskIntoConstraints = false
        return tableView
    }()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view.
        
        tableView.delegate = self
        tableView.dataSource = self
        
        self.view.addSubview(tableView)
        
        let tableviewConstraintH = NSLayoutConstraint.constraints(
            withVisualFormat: "H:|[tableView]|",
            options: .init(rawValue: 0),
            metrics: nil,
            views: ["tableView": self.tableView])
        let tableviewConstraintV = NSLayoutConstraint.constraints(
            withVisualFormat: "V:|[tableView]|",
            options: .init(rawValue: 0),
            metrics: nil,
            views: ["tableView": self.tableView])
        
        self.view.addConstraints(tableviewConstraintH)
        self.view.addConstraints(tableviewConstraintV)
        
        self.viewModel.callAPIService()
        self.viewModel.responseReceived = { [weak self] in
            guard let weakSelf = self else {
                return
            }
            
            DispatchQueue.main.async {
                weakSelf.tableView.reloadData()
            }
        }
    }
}

extension ViewController: UITableViewDataSource {
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
        let cell = UITableViewCell(style: .default, reuseIdentifier: "Cell")
        
        let product = self.viewModel.cellData(for: indexPath.row)
        cell.textLabel?.text = product.productName
        cell.detailTextLabel?.text = product.productID
        
        return cell
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return self.viewModel.numberOfRows()
    }
}

extension ViewController: UITableViewDelegate {
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 50
    }
}
