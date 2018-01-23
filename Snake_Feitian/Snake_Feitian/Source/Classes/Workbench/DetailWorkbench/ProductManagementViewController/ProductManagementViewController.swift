//
//  ProductManagementViewController.swift
//  Snake-OrderSystem
//
//  Created by Snake on 2017/11/20.
//  Copyright © 2017年 Snake. All rights reserved.
//

import UIKit
import SwiftyJSON
import Alamofire

class ProductManagementViewController: RefreshTableViewController {

    var seriesId: Int = 0
    
    override func viewDidLoad() {
        super.viewDidLoad()

        self.title = "产品管理"
        
        self.navBarAddRightBarButton(title: "添加")
    
        self.registerCellNib(nibName: "BaseTitleDetailTableViewCell")
        self.tableView.separatorStyle = .singleLine
        self.tableView.tableFooterView = UIView()

    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(true)
        //
        self.loadDataFromServer()
    }
    
    // =================================
    // MARK:
    // =================================
    
    override func loadDataFromServer() {
        let apiName: String = URLManager.feitian_product()
        let parameters: Parameters = ["seriesId": self.seriesId]
        //
        HttpManager.shareManager.getRequest(apiName, parameters: parameters).responseJSON { (response) in
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

    // =================================
    // MARK:
    // =================================
    
    override func navBarRightBarButtonDidTouch(_ sender: Any) {
        let vc = AddProductViewController()
        self.push(vc)
    }

}
