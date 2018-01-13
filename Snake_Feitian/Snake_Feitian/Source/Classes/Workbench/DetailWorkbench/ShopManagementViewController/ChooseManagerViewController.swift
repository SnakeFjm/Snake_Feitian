//
//  ChooseManagerViewController.swift
//  Snake_Feitian
//
//  Created by Snake on 2018/1/13.
//  Copyright © 2018年 Snake. All rights reserved.
//

import UIKit
import Alamofire

class ChooseManagerViewController: RefreshTableViewController {

    var choooseMangerCallback = {(managerId: Int) -> () in}
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        self.title = "选择店长"

        self.registerCellNib(nibName: "ShopManagementTableViewCell")
        self.tableView.rowHeight = 100
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
//        let parameters: Parameters = ["userId": 5]
        let apiName: String = URLManager.feitian_userBranchIdMinus1()
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

    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return self.dataArray.count
    }
    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell: ShopManagementTableViewCell = tableView.dequeueReusableCell(withIdentifier: "ShopManagementTableViewCell", for: indexPath) as! ShopManagementTableViewCell
        cell.updateCellUI(result: self.dataArray[indexPath.row])
        return cell
    }
    
    override func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        let shopManagerId: Int = self.dataArray[indexPath.row]["id"].intValue
        choooseMangerCallback(shopManagerId)
        self.back()
    }
    
}
