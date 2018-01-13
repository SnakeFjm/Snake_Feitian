//
//  EmployeesManagementViewController.swift
//  Snake-OrderSystem
//
//  Created by Snake on 2017/11/20.
//  Copyright © 2017年 Snake. All rights reserved.
//

import UIKit

class EmployeesManagementViewController: RefreshTableViewController {
    
    var branchId: Int = 0
    
    override func viewDidLoad() {
        super.viewDidLoad()

        self.navigationItem.title = "员工管理"
        
        self.navigationItem.rightBarButtonItem = UIBarButtonItem.init(title: "员工注册", style: .plain, target: self, action: #selector(addEmployees))

        self.registerCellNib(nibName: "EmployeesManagementTableViewCell")
        self.tableView.separatorStyle = .singleLine
        self.tableView.rowHeight = 100
        self.tableView.tableFooterView = UIView.init()

    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(true)
        
        self.loadDataFromServer()
    }
    
    // =================================
    // MARK:
    // =================================
    
    override func loadDataFromServer() {
        if self.branchId == 0 {
            if let id = SessionManager.share.basicInformation["branchId"] as? Int {
                self.branchId = id
            }
        }
        let apiName = URLManager.feitian_userBranch(branchId: self.branchId)
        //
        HttpManager.shareManager.getRequest(apiName).responseJSON { (response) in
            if let result = HttpManager.parseDataResponse(response: response) {
                self.dataArray = result.arrayValue
                
                self.reloadTableViewData()
            }
        }
    }
    
    // =================================
    // MARK:
    // =================================
    
    @objc func addEmployees() {
        
    }
    
    // =================================
    // MARK:
    // =================================
    
    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return self.dataArray.count
    }
    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
        let cell: EmployeesManagementTableViewCell = tableView.dequeueReusableCell(withIdentifier: "EmployeesManagementTableViewCell", for: indexPath) as! EmployeesManagementTableViewCell
        cell.updateCellUI(result: self.dataArray[indexPath.row])
        return cell
    }

}
