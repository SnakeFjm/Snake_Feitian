//
//  BodyStatusViewController.swift
//  Snake_Feitian
//
//  Created by Snake on 2018/1/14.
//  Copyright © 2018年 Snake. All rights reserved.
//

import UIKit

class BodyStatusViewController: RefreshTableViewController {

    var customerModel: CustomerModel!

    override func viewDidLoad() {
        super.viewDidLoad()

        self.title = "身体状况"
        
        self.navBarAddRightBarButton(title: "添加")
        
        //
        self.addMJHeaderView()
        self.addMJFooterView()
        //
        self.registerCellNib(nibName: "BodyStatusTableViewCell")
        self.tableView.rowHeight = 120
        self.tableView.tableFooterView = UIView.init()

    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        
        self.loadDataFromServer()
    }
    
    // =================================
    // MARK:
    // =================================
    
    override func loadDataFromServer() {
        let customerId = self.customerModel.id
        let apiName = URLManager.feitian_physicalStatusCustomer(customerId: customerId)
        //
        HttpManager.shareManager.getRequest(apiName).responseJSON { (response) in
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
        let cell: BodyStatusTableViewCell = tableView.dequeueReusableCell(withIdentifier: "BodyStatusTableViewCell", for: indexPath) as! BodyStatusTableViewCell
        
        let result = self.dataArray[indexPath.row]
        cell.updateCellUI(result: result)
        
        return cell
    }
    
    override func tableView(_ tableView: UITableView, editActionsForRowAt indexPath: IndexPath) -> [UITableViewRowAction]? {
        
        let deleteAction: UITableViewRowAction = UITableViewRowAction.init(style: .destructive, title: "删除") { (_, _) in

            let customerId = self.customerModel.id
            let apiName: String = URLManager.feitian_physicalStatusCustomer(customerId: customerId)
            //
            HttpManager.shareManager.deleteRequest(apiName).responseJSON(completionHandler: { (response) in
                if let _ = HttpManager.parseDataResponse(response: response) {
                    self.loadDataFromServer()
                    tableView.deleteRows(at: [indexPath], with: .top)
                }
            })
        }
        
        let editAction: UITableViewRowAction = UITableViewRowAction.init(style: .normal, title: "修改") { (_, _) in
            
            //TODO
            let editVC: AlterBodyStatusViewController = AlterBodyStatusViewController()
            self.hidesBottomBarWhenPushed = true
            self.navigationController?.pushViewController(editVC, animated: true)
            
        }
        
        return [deleteAction,editAction]
    }
    
    // =================================
    // MARK:
    // =================================
    
    override func navBarRightBarButtonDidTouch(_ sender: Any) {
        let vc = AddBodyStatusViewController()
        self.push(vc)
    }

}
