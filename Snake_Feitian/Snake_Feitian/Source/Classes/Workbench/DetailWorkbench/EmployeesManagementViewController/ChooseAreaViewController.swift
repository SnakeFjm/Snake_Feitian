//
//  ChooseAreaViewController.swift
//  Snake_Feitian
//
//  Created by Snake on 2018/1/21.
//  Copyright © 2018年 Snake. All rights reserved.
//

import UIKit

class ChooseAreaViewController: RefreshTableViewController {

    var chooseAreaCallback = {(areaId: Int, areaName: String) -> () in}
    
    override func viewDidLoad() {
        super.viewDidLoad()

        self.title = "选择区域"
        
        self.registerCellNib(nibName: "BaseTitleDetailTableViewCell")
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
        let apiName: String = URLManager.feitian_area()
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
        let cell: BaseTitleDetailTableViewCell = tableView.dequeueReusableCell(withIdentifier: "BaseTitleDetailTableViewCell", for: indexPath) as! BaseTitleDetailTableViewCell

        cell.title.text = self.dataArray[indexPath.row]["name"].stringValue
        
        return cell
    }
    
    override func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        let areaId = self.dataArray[indexPath.row]["id"].intValue
        let areaName = self.dataArray[indexPath.row]["name"].stringValue
        self.chooseAreaCallback(areaId, areaName)
        self.back()
    }

}
