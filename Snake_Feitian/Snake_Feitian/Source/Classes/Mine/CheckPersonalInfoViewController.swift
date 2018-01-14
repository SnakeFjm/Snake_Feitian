//
//  CheckPersonalInfoViewController.swift
//  Snake_Feitian
//
//  Created by Snake on 2018/1/14.
//  Copyright © 2018年 Snake. All rights reserved.
//

import UIKit

class CheckPersonalInfoViewController: RefreshTableViewController {

    var titleArray = ["姓名", "手机密码", "店铺", "地址", "出生日期"]
    
    var userModel: UserModel!
    
    override func viewDidLoad() {
        super.viewDidLoad()

        self.title = "个人信息"
        
        self.userModel = SessionManager.share.userModel
    
        self.registerCellNib(nibName: "BaseTitleDetailTableViewCell")
        self.tableView.separatorStyle = .singleLine
        self.tableView.rowHeight = 50
        self.tableView.tableFooterView = UIView()
        
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
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
        
        if indexPath.row == 0 {
            cell.detail.text = self.userModel.name
        } else if indexPath.row == 1 {
            cell.detail.text = self.userModel.contact
        } else if indexPath.row == 2 {
            cell.detail.text = ""
        } else if indexPath.row == 3 {
            cell.detail.text = self.userModel.address
        } else if indexPath.row == 4 {
            cell.detail.text = self.userModel.birthday
        }
        
        return cell
        
    }
    

}
