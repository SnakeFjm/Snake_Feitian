//
//  DetailCustomerViewController.swift
//  Snake-OrderSystem
//
//  Created by Snake on 2017/12/5.
//  Copyright © 2017年 Snake. All rights reserved.
//

import UIKit

class DetailCustomerViewController: BaseViewController, UITableViewDelegate, UITableViewDataSource {
    
    @IBOutlet weak var DetailCustomerTabelView: UITableView!
    
    var titleArray: [String] = ["客户姓名", "联系方式", "在用产品", "身体状况", "跟进员工"]
    var detailKeyArray: [String] = ["name", "contact", "productsUsingCount", "phyStatusUpdateTime", "followingEmployees"]
    
    var detailDict: NSMutableDictionary = [:]
    
    let dateFormatter: DateFormatter = DateFormatter.init()
    
    var customerId: Int = 0 //客户id
    
    override func viewDidLoad() {
        super.viewDidLoad()

        self.navigationItem.title = "客户详情"
        
        self.dateFormatter.dateFormat = "yyyy-MM-dd"
        
        self.DetailCustomerTabelView.register(UINib.init(nibName: "DetailCustomerTableViewCell", bundle: nil), forCellReuseIdentifier: "DetailCustomerTableViewCell")
        self.DetailCustomerTabelView.tableFooterView = UIView.init()
        
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
    
        let apiName: String = "http://123.207.68.190:21026/api/v1/customer/" + "\(self.customerId)"
//        HttpRequestManager.sharedManager.getRequest(apiName: apiName, paramDict: [:]) { (isSuccess: Bool, resultObject: Any) in
//
//            if isSuccess {
//                let array: NSArray = resultObject as! NSArray
//                let dict: NSDictionary = array[0] as! NSDictionary
//
//                self.detailDict = NSMutableDictionary.init(dictionary: dict)
//
//                self.DetailCustomerTabelView.reloadData()
//            }
//        }

    }
    
    // =================================
    // MARK:
    // =================================
    
    func numberOfSections(in tableView: UITableView) -> Int {
        return 2
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        if section == 0 {
            return self.titleArray.count
        }
        return 1
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell: DetailCustomerTableViewCell = self.DetailCustomerTabelView.dequeueReusableCell(withIdentifier: "DetailCustomerTableViewCell", for: indexPath) as! DetailCustomerTableViewCell
        
        if indexPath.section == 0 {
            
            cell.title.text = self.titleArray[indexPath.row]
            
            let key: String = self.detailKeyArray[indexPath.row]
            if let detail: String = self.detailDict.object(forKey: key) as? String {
                cell.detail.text = detail
            } else if let detail: Int = self.detailDict.object(forKey: key) as? Int {
                if key == "phyStatusUpdateTime" {
                    cell.detail.text = self.dateFormatter.string(from: Date.init(timeIntervalSince1970: TimeInterval(detail / 1000))) + "更新"
                } else if key == "productsUsingCount" {
                    cell.detail.text = "\(detail)" + "件"
                }
            }

        } else {
            cell.accessoryType = .disclosureIndicator
            cell.title.text = "更多"
            cell.detail.text = ""
        }
        
        return cell
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        if indexPath.section == 1 {
            
            let moreDetailVC: MoreDetailCustomerViewController = MoreDetailCustomerViewController()
            moreDetailVC.customerId = customerId
            
            self.hidesBottomBarWhenPushed = true
            self.navigationController?.pushViewController(moreDetailVC, animated: true)
        }
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 60
    }
    
    func tableView(_ tableView: UITableView, heightForHeaderInSection section: Int) -> CGFloat {
        if section == 0 {
            return 0
        }
        return 20
    }
}
