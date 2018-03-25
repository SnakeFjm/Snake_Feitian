//
//  FollowingEmployeesViewController.swift
//  Snake_Feitian
//
//  Created by Snake on 2018/1/14.
//  Copyright © 2018年 Snake. All rights reserved.
//

import UIKit

class FollowingEmployeesViewController: RefreshTableViewController {

    var customerModel: CustomerModel!
    
    override func viewDidLoad() {
        super.viewDidLoad()

        self.title = "跟进员工"
        
        // 如果该用户的身份不是店员或者店长，不显示右上角的“添加”按钮
        let role = SessionManager.share.userModel.role
        if role == 3 || role == 4 {
            self.navBarAddRightBarButton(title: "添加")
        }
        //
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
        super.viewWillAppear(animated)
        
        //
        self.loadDataFromServer()
    }
    
    // =================================
    // MARK:
    // =================================
    
    override func loadDataFromServer() {
        let customerId = self.customerModel.id
        let apiName = URLManager.feitian_userCustomer(customerId: customerId)
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
        let vc = DetailEmployeesManagementViewController()
        vc.userId = self.dataArray[indexPath.row]["id"].intValue
        self.push(vc)
        
    }
    
    // =================================
    // MARK:
    // =================================
    
    override func navBarRightBarButtonDidTouch(_ sender: Any) {
        let vc = AddFollowingEmployeesViewController()
        vc.customerId = self.customerModel.id
        self.push(vc)
    }
    

}
