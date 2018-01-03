//
//  MoreDetailCustomerViewController.swift
//  Snake-OrderSystem
//
//  Created by Snake on 2017/12/5.
//  Copyright © 2017年 Snake. All rights reserved.
//

import UIKit
import SwiftyJSON
import Alamofire

class MoreDetailCustomerViewController: BaseViewController, UITableViewDelegate, UITableViewDataSource {

    @IBOutlet weak var moreDetailCustomerTableView: UITableView!
    
    var titleArray: [String] = ["客户性别", "所在店铺", "出生日期", "备注"]
    var detailKeyArray: [String] = ["sex", "branchName", "birthday", "remarkName"]
    
    var detailDict: NSMutableDictionary = [:]
    
    var moreCustomerJson: JSON = []
    var customerId: Int = 0
    
    override func viewDidLoad() {
        super.viewDidLoad()

        self.navigationItem.title = "更多"
        
        self.moreDetailCustomerTableView.register(UINib.init(nibName: "DetailCustomerTableViewCell", bundle: nil), forCellReuseIdentifier: "DetailCustomerTableViewCell")
        self.moreDetailCustomerTableView.tableFooterView = UIView()
        
        self.loadDataFromServer()
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    // =================================
    // MARK:
    // =================================
    
    func loadDataFromServer() {
        
        let userId: Int = SessionManager.share.userId
        let apiName: String = URLManager.feitian_customerUser(userId: userId, customerId: self.customerId)
        //
        HttpManager.shareManager.getRequest(apiName).responseJSON { (response) in
            if let result = HttpManager.parseDataResponse(response: response) {
                self.moreCustomerJson = result
                //
                self.moreDetailCustomerTableView.reloadData()
            }
        }
    }
    
    // =================================
    // MARK:
    // =================================
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return self.titleArray.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
        let cell: DetailCustomerTableViewCell = self.moreDetailCustomerTableView.dequeueReusableCell(withIdentifier: "DetailCustomerTableViewCell", for: indexPath) as! DetailCustomerTableViewCell
        
        cell.title.text = self.titleArray[indexPath.row]
        let key: String = self.detailKeyArray[indexPath.row]
        //
        let detail = self.moreCustomerJson[key].stringValue
        cell.detail.text = detail
        if key == "sex" {
            let detail = self.moreCustomerJson["sex"].intValue
            if detail == 1 {
                cell.detail.text = "男"
            } else {
                cell.detail.text = "女"
            }
        }
        
        return cell
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 60
    }

}
