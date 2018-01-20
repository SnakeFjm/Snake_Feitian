//
//  DetailCustomerViewController.swift
//  Snake-OrderSystem
//
//  Created by Snake on 2017/12/5.
//  Copyright © 2017年 Snake. All rights reserved.
//

import UIKit
import SwiftyJSON
import Alamofire

class DetailCustomerViewController: BaseViewController, UITableViewDelegate, UITableViewDataSource {
    
    @IBOutlet weak var DetailCustomerTabelView: UITableView!
    
    var titleArray: [String] = ["客户姓名", "联系方式", "在用产品", "身体状况", "跟进员工"]
    var detailKeyArray: [String] = ["name", "contact", "productsUsingCount", "phyStatusUpdateTime", "followingEmployees"]
    
    var detailDict: NSMutableDictionary = [:]
    let dateFormatter: DateFormatter = DateFormatter.init()
    
    var customerJson: JSON = []
    var customerId: Int = 0 //客户id
    
    var customerModel: CustomerModel!
    
    override func viewDidLoad() {
        super.viewDidLoad()

        self.title = "客户详情"
        
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
    
    func loadDataFromServer() {
    
        let apiName: String = URLManager.feitian_customer(customerId: self.customerId)
        //
        HttpManager.shareManager.getRequest(apiName).responseJSON { (response) in
            if let result = HttpManager.parseDataResponse(response: response) {
                //
                self.customerJson = result
                //
                let dict: NSDictionary = HttpManager.jsonToNSDictionary(result: result[0])
                self.detailDict = NSMutableDictionary.init(dictionary: dict)
                
                self.DetailCustomerTabelView.reloadData()
            }
        }

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
            //
            cell.title.text = self.titleArray[indexPath.row]
            //
            let key: String = self.detailKeyArray[indexPath.row]
            let detail = self.customerJson[0][key].stringValue
            cell.detail.text = detail
            //
            if key == "phyStatusUpdateTime" {
                let detail = self.customerJson[0][key].intValue
                cell.detail.text = self.dateFormatter.string(from: Date.init(timeIntervalSince1970: TimeInterval.init(detail / 1000))) + "更新"
            } else if key == "productsUsingCount" {
                let detail = self.customerJson[0][key].intValue
                cell.detail.text = "\(detail)" + "件"
            }
        } else {
            cell.accessoryType = .disclosureIndicator
            cell.title.text = "更多"
            cell.detail.text = ""
        }
        
        return cell
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        
        let model = CustomerModel.init()
        model.id = self.customerId
        model.name = self.customerJson[indexPath.row]["name"].stringValue
        
        if indexPath.section == 0 && indexPath.row == 2 {
            // 在用产品
            let vc = ProductsUsingViewController()
            vc.customerModel = model
            self.push(vc)
            
        } else if indexPath.section == 0 && indexPath.row == 3 {
            // 身体状况
            let vc = BodyStatusViewController()
            vc.customerModel = model
            self.push(vc)
            
        } else if indexPath.section == 0 && indexPath.row == 4 {
            // 跟进员工
            let vc = FollowingEmployeesViewController()
            vc.customerModel = model
            self.push(vc)
            
        }
        
        if indexPath.section == 1 {
            // 更多
            let moreDetailVC: MoreDetailCustomerViewController = MoreDetailCustomerViewController()
            moreDetailVC.customerId = customerId
            //
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
