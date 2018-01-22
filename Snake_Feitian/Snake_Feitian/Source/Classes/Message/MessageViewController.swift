//
//  MessageViewController.swift
//  Snake-OrderSystem
//
//  Created by Snake on 2017/11/6.
//  Copyright © 2017年 Snake. All rights reserved.
//

import UIKit
import Alamofire
import SwiftyJSON

class MessageViewController: RefreshTableViewController {

    @IBOutlet weak var leftLabel: UILabel!
    @IBOutlet weak var rightLabel: UILabel!
    @IBOutlet weak var topView: UIView!
    
    var messageDict: NSDictionary = [:]
    
    var messageState: Int = 2   //1=已读，0=未读，2=全部
    var messageType: Int = 4    //1=工作消息，2=售后消息，3=其他消息，4=全部
    
    let dateFormatter = DateFormatter.init()
    
    override func viewDidLoad() {
        super.viewDidLoad()

        self.title = "我的消息"
        
        self.dateFormatter.dateFormat = "yyyy年MM月dd日 hh:mm"
        
        self.topView.layer.borderColor = UIColor.lightGray.cgColor
        self.topView.layer.borderWidth = 1
        
        //
        self.addMJHeaderView()
        self.addMJFooterView()
        //
        self.registerCellNib(nibName: "MessageTableViewCell")
        self.tableView.separatorStyle = .singleLine
        self.tableView.rowHeight = 100
        self.tableView.tableHeaderView = self.topView
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
        let parameters: Parameters = ["userId": userId, "isRead": self.messageState, "type": self.messageType, "pageNum": 0, "pageSize": 10]
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
    
    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return self.dataArray.count
    }
    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
        let cell = self.tableView.dequeueReusableCell(withIdentifier: "MessageTableViewCell", for: indexPath) as! MessageTableViewCell
        
        cell.titleLabel.text = self.dataArray[indexPath.row]["title"].stringValue
        cell.contentLabel.text = self.dataArray[indexPath.row]["content"].stringValue
        
        //
        let date = self.dataArray[indexPath.row]["createTime"].intValue
        let dateValue = self.dateFormatter.string(from: Date.init(timeIntervalSince1970: TimeInterval.init(date/1000)))
        cell.dateLabel.text = dateValue
        
        return cell
        
    }
    
    override func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        super.tableView(tableView, didSelectRowAt: indexPath)
        //
        let detailMessageVC = DetailMessageViewController()
        //
        detailMessageVC.titleValue = self.dataArray[indexPath.row]["title"].stringValue
        detailMessageVC.contentValue = self.dataArray[indexPath.row]["content"].stringValue
        detailMessageVC.messageId = self.dataArray[indexPath.row]["id"].intValue
        //
        let date = self.dataArray[indexPath.row]["createTime"].intValue
        let dateValue = self.dateFormatter.string(from: Date.init(timeIntervalSince1970: TimeInterval.init(date/1000)))
        detailMessageVC.dateValue = dateValue
    
        self.navigationController?.pushViewController(detailMessageVC, animated: true)
        
    }
    
    // =================================
    // MARK:
    // =================================

    @IBAction func leftViewTapGesture(_ sender: UITapGestureRecognizer) {
        
        let leftAlertVC: UIAlertController = UIAlertController.init(title: "请选择你需要的消息类型", message: "只能选择一项", preferredStyle: .actionSheet)
        
        let allAction: UIAlertAction = UIAlertAction.init(title: "全部", style: .default) { (action) in
            self.leftLabel.text = action.title
            self.messageState = 2
            self.loadDataFromServer()
        }
        let unReadAction: UIAlertAction = UIAlertAction.init(title: "未读", style: .default) { (action) in
            self.leftLabel.text = action.title
            self.messageState = 0
            self.loadDataFromServer()
        }
        let readAction: UIAlertAction = UIAlertAction.init(title: "已读", style: .default) { (action) in
            self.leftLabel.text = action.title
            self.messageState = 1
            self.loadDataFromServer()
        }
        let cancelAction: UIAlertAction = UIAlertAction.init(title: "取消", style: .cancel, handler: nil)
        
        leftAlertVC.addAction(allAction)
        leftAlertVC.addAction(unReadAction)
        leftAlertVC.addAction(readAction)
        leftAlertVC.addAction(cancelAction)
        
        self.present(leftAlertVC, animated: true, completion: nil)
    }
    
    @IBAction func rightViewTapGesture(_ sender: UITapGestureRecognizer) {
        
        let rightAlertVC: UIAlertController = UIAlertController.init(title: "请选择你需要的消息类型", message: "只能选择一项", preferredStyle: .actionSheet)

        let allAction: UIAlertAction = UIAlertAction.init(title: "全部", style: .default) { (action) in
            self.rightLabel.text = action.title
            self.messageType = 4
            self.loadDataFromServer()
        }
        let afterServiceMsgAction: UIAlertAction = UIAlertAction.init(title: "售后消息", style: .default) { (action) in
            self.rightLabel.text = action.title
            self.messageType = 2
            self.loadDataFromServer()
        }
        let workMsgAction: UIAlertAction = UIAlertAction.init(title: "工作消息", style: .default) { (action) in
            self.rightLabel.text = action.title
            self.messageType = 1
            self.loadDataFromServer()
        }
        let otherMsgAction: UIAlertAction = UIAlertAction.init(title: "其他消息", style: .default) { (action) in
            self.rightLabel.text = action.title
            self.messageType = 3
            self.loadDataFromServer()
        }
        let cancelAction: UIAlertAction = UIAlertAction.init(title: "取消", style: .cancel, handler: nil)
        
        rightAlertVC.addAction(allAction)
        rightAlertVC.addAction(afterServiceMsgAction)
        rightAlertVC.addAction(workMsgAction)
        rightAlertVC.addAction(otherMsgAction)
        rightAlertVC.addAction(cancelAction)
        
        self.present(rightAlertVC, animated: true, completion: nil)
    }
    
}
