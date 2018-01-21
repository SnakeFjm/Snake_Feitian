//
//  AfterSalesManagementViewController.swift
//  Snake-OrderSystem
//
//  Created by Snake on 2017/11/20.
//  Copyright © 2017年 Snake. All rights reserved.
//

import UIKit

class AfterSalesManagementViewController: RefreshTableViewController {
        
    let dateFormatter = DateFormatter.init()
    
    var userId: Int = 0
    
    override func viewDidLoad() {
        super.viewDidLoad()

        self.title = "售后管理"
        //
        self.navBarAddRightBarButton(title: "新增记录")
        //
        self.dateFormatter.dateFormat = "yyyy-MM-dd"
        
        //
        self.addMJHeaderView()
        self.addMJFooterView()
        //
        self.registerCellNib(nibName: "AfterSaleTableViewCell")
        self.tableView.separatorStyle = .singleLine
        self.tableView.rowHeight = 80
        self.tableView.tableFooterView = UIView.init()
        
        self.reloadTableViewData()
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
        
        self.userId = (self.userId == 0) ? SessionManager.share.userId : self.userId
        let apiName = URLManager.feitian_followUp_user(userId: self.userId)
        
        HttpManager.shareManager.getRequest(apiName, pageNum: self.currentPage, pageSize: self.pageSize, parameters: nil).responseJSON { (response) in
            if let result = HttpManager.parseDataResponse(response: response) {
                self.dataArray = result["elements"].arrayValue
                // 数据更新
                if self.pullType == .pullDown {
                    self.dataArray = result["elements"].arrayValue
                } else {
                    self.dataArray.append(contentsOf: result["elements"].arrayValue)
                }
                // 是否能够加载更多
                self.canLoadMore = HttpManager.checkIfCanLoadMOre(currentPage: self.currentPage, result: result)
                // 刷新数据
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
        
        let cell = self.tableView.dequeueReusableCell(withIdentifier: "AfterSaleTableViewCell", for: indexPath) as! AfterSaleTableViewCell
        
        cell.customerNameLabel.text = self.dataArray[indexPath.row]["customerName"].stringValue
        cell.productLabel.text = self.dataArray[indexPath.row]["product"].stringValue
        
        //
        let date = self.dataArray[indexPath.row]["deadline"].intValue
        let dateValue = self.dateFormatter.string(from: Date.init(timeIntervalSince1970: TimeInterval.init(date/1000)))
        cell.deadlineLabel.text = dateValue
        
        return cell
        
    }
    
    override func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        super.tableView(tableView, didSelectRowAt: indexPath)
        //
        let model: AfterSaleModel = AfterSaleModel()
        model.id = self.dataArray[indexPath.row]["id"].intValue
        model.customerName = self.dataArray[indexPath.row]["customerName"].stringValue
        model.product = self.dataArray[indexPath.row]["product"].stringValue
        //
        let date = self.dataArray[indexPath.row]["deadline"].intValue
        let dateValue = self.dateFormatter.string(from: Date.init(timeIntervalSince1970: TimeInterval.init(date/1000)))
        model.deadline = dateValue
        //
        let afterSaleDetailVC = AfterSaleDetailViewController()
        afterSaleDetailVC.afterSaleModel = model
        self.push(afterSaleDetailVC)
        
    }
    
    // =================================
    // MARK:
    // =================================
    
    override func navBarRightBarButtonDidTouch(_ sender: Any) {
        
    }
    
}
