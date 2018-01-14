//
//  NewsReleaseViewController.swift
//  Snake-OrderSystem
//
//  Created by Snake on 2017/11/20.
//  Copyright © 2017年 Snake. All rights reserved.
//

import UIKit
import Alamofire
import SwiftyJSON

class NewsReleaseViewController: RefreshTableViewController {

    @IBOutlet var headView: UIView!
    
    let dateFormatter = DateFormatter.init()

    override func viewDidLoad() {
        super.viewDidLoad()

        self.title = "消息发布"
        //
        self.dateFormatter.dateFormat = "yyyy年MM月dd日 hh:mm"
        //
        self.navBarAddRightBarButton(title: "新消息")
        //
        self.addMJHeaderView()
        self.addMJFooterView()
        //
        self.registerCellNib(nibName: "MessageTableViewCell")
        self.tableView.separatorStyle = .singleLine
        self.tableView.rowHeight = 100
        self.tableView.tableHeaderView = self.headView
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
        
        let userId = SessionManager.share.userId
        let parameters: Parameters = ["userId": userId]
        let apiName = URLManager.feitian_message()
        
        HttpManager.shareManager.getRequest(apiName, pageNum: self.currentPage, pageSize: self.pageSize, parameters: parameters).responseJSON { (response) in
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
    
    // =================================
    // MARK:
    // =================================
    
    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return self.dataArray.count
    }
    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
        let cell = self.tableView.dequeueReusableCell(withIdentifier: "MessageTableViewCell", for: indexPath) as! MessageTableViewCell
        
        cell.titleLabel.text = self.dataArray[indexPath.row]["title"].stringValue
        cell.contentLabel.text = self.dataArray[indexPath.row]["content"].stringValue
        
        //
        let date = self.dataArray[indexPath.row]["modifyTime"].intValue
        let dateValue = self.dateFormatter.string(from: Date.init(timeIntervalSince1970: TimeInterval.init(date/1000)))
        cell.dateLabel.text = dateValue
        
        return cell
        
    }
    

    // =================================
    // MARK:
    // =================================
    
    override func navBarRightBarButtonDidTouch(_ sender: Any) {
        let vc = AddNewsReleaseViewController()
        self.push(vc)
    }
    

}
