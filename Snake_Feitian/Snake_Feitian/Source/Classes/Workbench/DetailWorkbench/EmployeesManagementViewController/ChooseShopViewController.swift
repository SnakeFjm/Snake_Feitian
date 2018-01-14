//
//  ChooseShopViewController.swift
//  Snake_Feitian
//
//  Created by Snake on 2018/1/13.
//  Copyright © 2018年 Snake. All rights reserved.
//

import UIKit

class ChooseShopViewController: RefreshTableViewController {

    var chooseShopCallback = {(branchId: Int) -> () in}
    
    override func viewDidLoad() {
        super.viewDidLoad()

        self.title = "选择店铺"
        
        self.registerCellNib(nibName: "ShopManagementTableViewCell")
        self.tableView.rowHeight = 80
        self.tableView.tableFooterView = UIView()
        //
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
        let apiName: String = URLManager.Feitian_branch()
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
    
    override func numberOfSections(in tableView: UITableView) -> Int {
        return self.dataArray.count
    }
    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell: ShopManagementTableViewCell = tableView.dequeueReusableCell(withIdentifier: "ShopManagementTableViewCell", for: indexPath) as! ShopManagementTableViewCell
        
        let result = self.dataArray[indexPath.row]
        cell.updateCellUI(result: result)
        
        return cell
    }
    
    override func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        let branchId = self.dataArray[indexPath.row]["id"].intValue
        self.chooseShopCallback(branchId)
        self.back()
    }

}
