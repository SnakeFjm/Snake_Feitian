//
//  MoreDetailCustomerViewController.swift
//  Snake-OrderSystem
//
//  Created by Snake on 2017/12/5.
//  Copyright © 2017年 Snake. All rights reserved.
//

import UIKit

class MoreDetailCustomerViewController: BaseViewController, UITableViewDelegate, UITableViewDataSource {

    @IBOutlet weak var moreDetailCustomerTableView: UITableView!
    
    var titleArray: [String] = ["客户性别", "所在店铺", "出生日期", "备注"]
    var detailKeyArray: [String] = ["sex", "branchName", "birthday", "remarkName"]
    
    var detailDict: NSMutableDictionary = [:]
    
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
        let apiName: String = "http://123.207.68.190:21026/api/v1/customer/user/" + "\(userId)" + "more-detail/" + "\(self.customerId)"
        
//        HttpRequestManager.sharedManager.getRequest(apiName: apiName, paramDict: [:]) { (isSuccess: Bool, resultObject: Any) in
//            
//            if isSuccess {
//                
//                let dict: NSDictionary = resultObject as! NSDictionary
//                
//                self.detailDict = NSMutableDictionary.init(dictionary: dict)
//                
//                self.moreDetailCustomerTableView.reloadData()
//            }
//        }
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
        if let detail: String = self.detailDict.object(forKey: key) as? String {
            cell.detail.text = detail
        } else if let detail: Int = self.detailDict.object(forKey: key) as? Int {
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
