//
//  MessageViewController.swift
//  Snake-OrderSystem
//
//  Created by Snake on 2017/11/6.
//  Copyright © 2017年 Snake. All rights reserved.
//

import UIKit

class MessageViewController: BaseViewController, UITableViewDelegate, UITableViewDataSource {

    @IBOutlet weak var leftLabel: UILabel!
    
    @IBOutlet weak var rightLabel: UILabel!
    
    @IBOutlet weak var topView: UIView!
    
    @IBOutlet weak var messageTableView: UITableView!
    
    var messageDict: NSDictionary = [:]
    
    var messageArray: NSMutableArray = []
    
    var messageState: Int = 2   //1=已读，0=未读，2=全部
    var messageType: Int = 4    //1=工作消息，2=售后消息，3=其他消息，4=全部
    
    let dateFormatter = DateFormatter.init()
    
    override func viewDidLoad() {
        super.viewDidLoad()

        self.navigationItem.title = "我的消息"
        
        self.dateFormatter.dateFormat = "yyyy年MM月dd日 hh:mm"
        
        self.topView.layer.borderColor = UIColor.lightGray.cgColor
        self.topView.layer.borderWidth = 1
        
        self.messageTableView.register(UINib.init(nibName: "MessageTableViewCell", bundle: nil), forCellReuseIdentifier: "MessageTableViewCell")
        self.messageTableView.tableFooterView = UIView()
        
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
        let dict = ["userId": 1, "isRead": self.messageState, "type": self.messageType, "pageNum": 0, "pageSize": 10]
        let apiName = "http://123.207.68.190:21026/api/v1/message"
        
//        HttpRequestManager.sharedManager.getRequest(apiName: apiName, paramDict: dict) { (isSuccess, resultObject) in
//            
//            if isSuccess {
//                
//                self.messageDict = NSDictionary.init(dictionary: resultObject as! NSDictionary)
//                self.messageArray = NSMutableArray.init(array: (self.messageDict.object(forKey: "elements") as! NSArray))
//                
//                self.messageTableView.reloadData()
//            }
//        }
        
        
    }
    
    // =================================
    // MARK:
    // =================================
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return self.messageArray.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
        let cell = self.messageTableView.dequeueReusableCell(withIdentifier: "MessageTableViewCell", for: indexPath) as! MessageTableViewCell
        
        let dict: NSDictionary = self.messageArray[indexPath.row] as! NSDictionary
        
        cell.titleLabel.text = dict.object(forKey: "title") as? String
        cell.contentLabel.text = dict.object(forKey: "content") as? String
        
        let date = dict.object(forKey: "modifyTime") as? Int
        let dateValue = self.dateFormatter.string(from: Date.init(timeIntervalSince1970: TimeInterval.init(date!/1000)))
        cell.dateLabel.text = dateValue
        
        return cell
        
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        
        let dict: NSDictionary = self.messageArray[indexPath.row] as! NSDictionary
        
        let detailMessageVC = DetailMessageViewController()
        
        detailMessageVC.titleValue = dict.object(forKey: "title") as! String
        detailMessageVC.contentValue = dict.object(forKey: "content") as! String
        
        let date = dict.object(forKey: "modifyTime") as? Int
        let dateValue = self.dateFormatter.string(from: Date.init(timeIntervalSince1970: TimeInterval.init(date!/1000)))
        detailMessageVC.dateValue = dateValue

    
        self.navigationController?.pushViewController(detailMessageVC, animated: true)
        
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 100
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
