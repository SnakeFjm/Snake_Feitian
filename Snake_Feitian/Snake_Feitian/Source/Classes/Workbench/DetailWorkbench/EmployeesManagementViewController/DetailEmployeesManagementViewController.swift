//
//  DetailEmployeesManagementViewController.swift
//  Snake_Feitian
//
//  Created by Snake on 2018/1/20.
//  Copyright © 2018年 Snake. All rights reserved.
//

import UIKit
import Alamofire
import SwiftyJSON

class DetailEmployeesManagementViewController: RefreshTableViewController {

    var titleArray = ["姓名", "店铺", "性别", "住址", "联系方式"] // 售后处理
    
    var detailJson: JSON = []
    
    var userId: Int = 0

    override func viewDidLoad() {
        super.viewDidLoad()

        self.title = "员工详情"
        
        self.registerCellNib(nibName: "BaseTitleDetailTableViewCell")
        self.tableView.separatorStyle = .singleLine
        self.tableView.tableFooterView = UIView.init()
        self.tableView.sectionFooterHeight = 15
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
        
        let apiName = URLManager.feitian_user(userId: self.userId)
        //
        HttpManager.shareManager.getRequest(apiName).responseJSON { (response) in
            if let result = HttpManager.parseDataResponse(response: response) {
                //
                self.detailJson = result
                //
                self.reloadTableViewData()
            }
        }
        
    }
    
    // =================================
    // MARK:
    // =================================
    
    override func numberOfSections(in tableView: UITableView) -> Int {
        return 2
    }
    
    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        if section == 0 {
            return self.titleArray.count
        } else {
            return 1
        }
    }
    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
        let cell = self.tableView.dequeueReusableCell(withIdentifier: "BaseTitleDetailTableViewCell", for: indexPath) as! BaseTitleDetailTableViewCell
        
        if indexPath.section == 0 {
            //
            cell.title.text = self.titleArray[indexPath.row]
            //
            if indexPath.row == 0 {
                cell.detail.text = self.detailJson["name"].stringValue
            }
            if indexPath.row == 1 {
                cell.detail.text = self.detailJson["branchName"].stringValue
            }
            if indexPath.row == 2 {
                cell.detail.text = self.detailJson["sex"].stringValue
            }
            if indexPath.row == 3 {
                cell.detail.text = self.detailJson["address"].stringValue
            }
            if indexPath.row == 4 {
                cell.detail.text = self.detailJson["contact"].stringValue
            }
        } else if indexPath.section == 1 {
            cell.accessoryType = .disclosureIndicator
            cell.title.text = "售后管理"
        }
        
        return cell
        
    }
    
    override func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        super.tableView(tableView, didSelectRowAt: indexPath)
        //
        if indexPath.section == 1 {
            let vc = AfterSalesManagementViewController()
            vc.userId = self.detailJson["id"].intValue
            self.push(vc)
        }
    }
    
    func tableView(_ tableView: UITableView, heightForFooterInSection section: Int) -> CGFloat {
        if section == 0 {
            return 15
        } else {
            return 0
        }
    }

}
