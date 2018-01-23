//
//  ChooseSeriesViewController.swift
//  Snake_Feitian
//
//  Created by Snake on 2018/1/23.
//  Copyright © 2018年 Snake. All rights reserved.
//

import UIKit

class ChooseSeriesViewController: RefreshTableViewController {

    var chooseSeriesCallback = {(seriesId: Int, seriesName: String) -> () in}
    
    override func viewDidLoad() {
        super.viewDidLoad()

        self.title = "选择产品系列"
        
        self.registerCellNib(nibName: "BaseTitleDetailTableViewCell")
        self.tableView.separatorStyle = .singleLine
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
        let apiName: String = URLManager.feitian_productSeries()
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
        let cell: BaseTitleDetailTableViewCell = tableView.dequeueReusableCell(withIdentifier: "BaseTitleDetailTableViewCell", for: indexPath) as! BaseTitleDetailTableViewCell
        
        cell.title.text = self.dataArray[indexPath.row]["name"].stringValue
        
        return cell
    }
    
    override func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        super.tableView(tableView, didSelectRowAt: indexPath)
        let seriesId = self.dataArray[indexPath.row]["id"].intValue
        let seriesName = self.dataArray[indexPath.row]["name"].stringValue
        self.chooseSeriesCallback(seriesId, seriesName)
        self.back()
    }

}
