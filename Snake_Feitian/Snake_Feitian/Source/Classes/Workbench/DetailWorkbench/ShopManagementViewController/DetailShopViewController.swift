//
//  DetailShopViewController.swift
//  Snake-OrderSystem
//
//  Created by Snake on 2017/12/2.
//  Copyright © 2017年 Snake. All rights reserved.
//

import UIKit

class DetailShopViewController: RefreshTableViewController {

    var branchId: Int = 0
    
    var titleArray: [String] = ["店铺名", "店长", "店员数量", "店铺地址", "联系方式"]
    
    override func viewDidLoad() {
        super.viewDidLoad()

        self.navigationItem.title = "店铺详情"
        self.registerCellNib(nibName: "BaseTitleDetailTableViewCell")
        self.tableView.separatorStyle = .singleLine
        self.tableView.rowHeight = 70
        self.tableView.tableFooterView = UIView.init()
        
        self.loadDataFromServer()
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    // =================================
    // MARK:
    // =================================
    
    override func loadDataFromServer() {
        let apiName: String = URLManager.Feitian_branch(branchId: self.branchId)
        
        HttpManager.shareManager.getRequest(apiName).responseJSON { (response) in
            if let result = HttpManager.parseDataResponse(response: response) {
                self.dataArray.append(result)
                //
                self.reloadTableViewData()
            }
        }
    }
    
    // =================================
    // MARK:
    // =================================
    
    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return self.titleArray.count
    }
    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell: BaseTitleDetailTableViewCell = tableView.dequeueReusableCell(withIdentifier: "BaseTitleDetailTableViewCell", for: indexPath) as! BaseTitleDetailTableViewCell
        
        cell.title.text = self.titleArray[indexPath.row]
        
        if self.dataArray.count > 0 {
            switch indexPath.row {
            case 0:
                cell.detail.text = self.dataArray[0]["name"].stringValue
            case 1:
                cell.detail.text = self.dataArray[0]["shopManagerName"].stringValue
            case 2:
                cell.detail.text = self.dataArray[0]["employeesCount"].stringValue
            case 3:
                cell.detail.text = self.dataArray[0]["address"].stringValue
            case 4:
                cell.detail.text = self.dataArray[0]["contact"].stringValue
            default:
                break
            }
        }

        return cell
    }

    override func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        if indexPath.row == 2 {
            // 进入员工管理
            let eManagementVC: EmployeesManagementViewController = EmployeesManagementViewController()
            eManagementVC.branchId = self.branchId
            self.push(eManagementVC)
        }
    }
}
