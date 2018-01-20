//
//  AfterSaleDetailViewController.swift
//  Snake_Feitian
//
//  Created by Snake on 2018/1/20.
//  Copyright © 2018年 Snake. All rights reserved.
//

import UIKit
import SwiftyJSON
import Alamofire

class AfterSaleDetailViewController: RefreshTableViewController {

    let dateFormatter = DateFormatter.init()
    
    var titleArray: [String] = ["客户姓名", "联系方式", "在用产品", "身体状况"]
    var titleEtraArray: [String] = ["跟进人", "处理时间", "售后记录", "备注"]
    
    var afterSaleModel: AfterSaleModel!
    
    var afterSaleJson: JSON = []

    override func viewDidLoad() {
        super.viewDidLoad()
        //
        self.title = "售后详情"
        //
        self.dateFormatter.dateFormat = "yyyy-MM-dd hh:mm"
        
        self.registerCellNib(nibName: "BaseTitleDetailTableViewCell")
        self.tableView.separatorStyle = .singleLine
        self.tableView.sectionHeaderHeight = 20
        self.tableView.sectionFooterHeight = 20
        self.tableView.tableFooterView = UIView.init()

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
        
        let followUpId = self.afterSaleModel.id
        let apiName = URLManager.feitian_followUp(followUpId: followUpId)
        
        HttpManager.shareManager.getRequest(apiName).responseJSON { (response) in
            if let resutl = HttpManager.parseDataResponse(response: response) {
                //
                self.afterSaleJson = resutl
                
                self.reloadTableViewData()
            }
        }
        
    }
    
    // =================================
    // MARK:
    // =================================
    
    override func numberOfSections(in tableView: UITableView) -> Int {
        return 2
    }
    
    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        if section == 0 {
            return self.titleArray.count
        } else {
            return self.titleEtraArray.count
        }
    }

    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
        let cell: BaseTitleDetailTableViewCell = tableView.dequeueReusableCell(withIdentifier: "BaseTitleDetailTableViewCell", for: indexPath) as! BaseTitleDetailTableViewCell
        
        if indexPath.section == 0 {
            cell.title.text = self.titleArray[indexPath.row]
            //
            if indexPath.row == 0 {
                cell.detail.text = "\(self.afterSaleModel.id)"
            }
            if indexPath.row == 1 {
                cell.detail.text = self.afterSaleModel.customerName
            }
            if indexPath.row == 2 {
                cell.detail.text = self.afterSaleModel.product
            }
            if indexPath.row == 3 {
                cell.detail.text = self.afterSaleModel.deadline + "过期"
            }
        }
        
        if indexPath.section == 1 {
            //
            cell.title.text = self.titleEtraArray[indexPath.row]
            //
            if indexPath.row == 0 {
                cell.detail.text = self.afterSaleJson["followers"].stringValue
            }
            if indexPath.row == 1 {
                let date = self.afterSaleJson["processTime"].intValue
                let dateValue = self.dateFormatter.string(from: Date.init(timeIntervalSince1970: TimeInterval.init(date/1000)))
                cell.detail.text = dateValue + "过期"
            }
            if indexPath.row == 2 {
                cell.detail.text = self.afterSaleJson["afterSaleRecord"].stringValue
            }
            if indexPath.row == 3 {
                cell.detail.text = self.afterSaleJson["remark"].stringValue
            }
        }
        
        return cell
    }
    
    func tableView(_ tableView: UITableView, heightForFooterInSection section: Int) -> CGFloat {
        if section == 0 {
            return 20
        }
        return 0
    }


}
