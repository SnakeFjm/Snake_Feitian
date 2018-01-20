//
//  AddBodyStatusViewController.swift
//  Snake_Feitian
//
//  Created by Snake on 2018/1/14.
//  Copyright © 2018年 Snake. All rights reserved.
//

import UIKit
import SwiftyJSON
import Alamofire

class AddBodyStatusViewController: BaseViewController {

    @IBOutlet weak var bodyStatusTextView: UITextView!
    
    var customerModel: CustomerModel!
    
    override func viewDidLoad() {
        super.viewDidLoad()

        self.title = "添加身体状况记录"
        
        self.bodyStatusTextView.layer.borderWidth = 1
        self.bodyStatusTextView.layer.borderColor = UIColor.black.cgColor
        
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    // =================================
    // MARK:
    // =================================
    
    @IBAction func addButtonDidTouch(_ sender: Any) {
        
        if self.bodyStatusTextView.text.isEmpty {
            self.showErrorTips("内容不能为空")
            return
        }
        
        let creator = SessionManager.share.userModel.name
        let customerId = self.customerModel.id
        let physicalStatus: String = self.bodyStatusTextView.text
        //
        let parameters: Parameters = ["creator": creator, "customerId": customerId, "physicalStatus": physicalStatus]
        let apiName = URLManager.feitian_physicalStatus()
        //
        HttpManager.shareManager.postRequest(apiName, parameters: parameters, encoding: JSONEncoding.default).responseJSON { (response) in
            if let _ = HttpManager.parseDataResponse(response: response) {
                self.back()
            }
        }
        
        
        
    }
    

}
