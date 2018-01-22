//
//  DetailMessageViewController.swift
//  Snake-OrderSystem
//
//  Created by Snake on 2017/12/7.
//  Copyright © 2017年 Snake. All rights reserved.
//

import UIKit
import SwiftyJSON
import Alamofire

class DetailMessageViewController: BaseViewController {

    var titleValue: String = ""     //标题
    var dateValue: String = ""      //日期
    var contentValue: String = ""   //内容
    
    var messageId: Int = 0
    
    var messageJson: JSON = []
    
    let dateFormatter = DateFormatter.init()
    
    @IBOutlet weak var titleLabel: UILabel!
    @IBOutlet weak var dateLabel: UILabel!
    @IBOutlet weak var contentLabel: UILabel!
    
    override func viewDidLoad() {
        super.viewDidLoad()

        self.navigationItem.title = "消息详情"
        
        self.dateFormatter.dateFormat = "yyyy年MM月dd日 hh:mm"

        self.updateView(result: messageJson)
        
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
        let userId: Int = SessionManager.share.userModel.id
        let apiName = URLManager.feitian_message(messageId: self.messageId, userId: userId)
        //
        HttpManager.shareManager.getRequest(apiName).responseJSON { (response) in
            if let result = HttpManager.parseDataResponse(response: response) {
                self.messageJson = result
                
                self.updateView(result: self.messageJson)
            }
        }
    }
    
    // =================================
    // MARK:
    // =================================
    
    func updateView(result: JSON) {
        //
        let date = result["createTime"].intValue
        let dateValue = self.dateFormatter.string(from: Date.init(timeIntervalSince1970: TimeInterval.init(date/1000)))
        
        self.titleLabel.text = result["title"].stringValue
        self.contentLabel.text = result["content"].stringValue
        self.dateLabel.text = dateValue
    }
    

}
