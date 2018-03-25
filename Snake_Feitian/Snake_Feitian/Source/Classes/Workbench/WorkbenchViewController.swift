//
//  WorkbenchViewController.swift
//  Snake-OrderSystem
//
//  Created by Snake on 2017/11/6.
//  Copyright © 2017年 Snake. All rights reserved.
//

import UIKit

class WorkbenchViewController: BaseViewController, UITableViewDelegate, UITableViewDataSource {

    @IBOutlet weak var workbenchTableView: UITableView!
    
    let dataList: [String] = ["我的客户", "售后管理", "产品管理", "员工管理", "消息发布", "店铺管理"]
    let dataListVC: [String] = ["MineCustomerViewController", "AfterSalesManagementViewController", "ProductManagementViewController", "EmployeesManagementViewController", "NewsReleaseViewController", "ShopManagementViewController"]
    
    let arrayVC = [MineCustomerViewController(), AfterSalesManagementViewController(), ProductManagementViewController(), EmployeesManagementViewController(), NewsReleaseViewController(), ShopManagementViewController()]
    
    override func viewDidLoad() {
        super.viewDidLoad()

        self.title = "工作台"
        
        self.workbenchTableView.register(workbenchTableViewCell.classForCoder(), forCellReuseIdentifier: "workbenchCell")
        self.workbenchTableView.tableFooterView = UIView.init()
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    func numberOfSections(in tableView: UITableView) -> Int {
        return 3
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return 2
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
        let cell: workbenchTableViewCell = tableView.dequeueReusableCell(withIdentifier: "workbenchCell", for: indexPath) as! workbenchTableViewCell
        
        let row: Int = indexPath.section * 2 + indexPath.row
        cell.textLabel?.text = self.dataList[row]
        cell.accessoryType = .disclosureIndicator
        
        return cell
        
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 60
    }
    
    func tableView(_ tableView: UITableView, heightForHeaderInSection section: Int) -> CGFloat {

        if section == 0 {
            return 0
        }

        return 20
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        
        let cell: workbenchTableViewCell = tableView.cellForRow(at: indexPath) as! workbenchTableViewCell
        cell.setSelected(false, animated: true)
        
        let indexVC: Int = indexPath.section * 2 + indexPath.row
        // 权限控制
        if self.authorityControl(indexVC: indexVC) == false {
            self.showErrorTips("你没有权限")
            self.perform(#selector(hideTips), with: self, afterDelay: 1)
            return
        }
        //
        let detailWorkbenchVC = self.arrayVC[indexVC]
        self.hidesBottomBarWhenPushed = true
        self.navigationController?.pushViewController(detailWorkbenchVC, animated: true)

    }
    
    // =================================
    // MARK:
    // =================================
    
    // 权限控制
    func authorityControl(indexVC: Int) -> Bool {
        
        let role = SessionManager.share.userModel.role
        
        // 员工
        if role == role_FeiTian.clerk.rawValue {
            if indexVC > 1 {
                return false
            }
        }
        
        if role == role_FeiTian.shopowner.rawValue || role == role_FeiTian.regionalManager.rawValue {
            if indexVC == 2 {
                return false
            }
        }
        
        if role == role_FeiTian.executiveAssistant.rawValue || role == role_FeiTian.generalManager.rawValue {
            return true
        }
        
        return true
    }
    
    
}

//一、工作台
//普通员工可见：
    //我的客户
    //售后管理
//店长可见：
    //我的客户
    //售后管理
    //员工管理
    //店铺管理
    //消息发布
//区域经理可见
    //我的客户
    //售后管理
    //员工管理
    //店铺管理
    //消息发布
//总经理/经理助理：
    //所有

