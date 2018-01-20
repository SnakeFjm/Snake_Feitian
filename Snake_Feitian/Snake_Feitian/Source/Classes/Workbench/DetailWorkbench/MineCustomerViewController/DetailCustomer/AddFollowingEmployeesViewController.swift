//
//  AddFollowingEmployeesViewController.swift
//  Snake_Feitian
//
//  Created by Snake on 2018/1/14.
//  Copyright © 2018年 Snake. All rights reserved.
//

import UIKit
import SwiftyJSON
import Alamofire

class AddFollowingEmployeesViewController: RefreshTableViewController {

    var customerModel: CustomerModel!
    
    var branchId: Int = 0
    var customerId: Int = 0
    
    override func viewDidLoad() {
        super.viewDidLoad()

        self.title = "添加员工"
        
        self.registerCellNib(nibName: "EmployeesManagementTableViewCell")
        self.tableView.separatorStyle = .singleLine
        self.tableView.rowHeight = 100
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
        self.branchId = SessionManager.share.userModel.branchId
        let apiName = URLManager.feitian_userBranchCustomer(branchId: self.branchId, customerId: self.customerId)
        //
        HttpManager.shareManager.getRequest(apiName).responseJSON { (response) in
            if let result = HttpManager.parseDataResponse(response: response) {
                //
                self.dataArray = result.arrayValue
                //
                self.reloadTableViewData()
            }
        }
    }
    
    // =================================
    // MARK:
    // =================================
    
    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return self.dataArray.count
    }
    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell: EmployeesManagementTableViewCell = tableView.dequeueReusableCell(withIdentifier: "EmployeesManagementTableViewCell", for: indexPath) as! EmployeesManagementTableViewCell
        
        let result = self.dataArray[indexPath.row]
        cell.updateCellUI(result: result)
        
        return cell
    }
    
    override func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        super.tableView(tableView, didSelectRowAt: indexPath)
        // TODO
        let remarkName = self.dataArray[indexPath.row]["name"].stringValue
        let employeeId = self.dataArray[indexPath.row]["id"].intValue
        //
        let parameters: Parameters = ["customerId": self.customerId,
                                      "employeeId": employeeId,
                                      "remarkName": remarkName]
        let apiName = URLManager.feitian_customerFollower()
        //
        HttpManager.shareManager.postRequest(apiName, parameters: parameters, encoding: JSONEncoding.default).responseJSON { (response) in
            if let _ = HttpManager.parseDataResponse(response: response) {
                self.showSuccessTips("添加成功")
                self.back()
            } else {
                self.showErrorTips("添加失败")
            }
        }
        
    }

}
