//
//  AddProductViewController.swift
//  Snake_Feitian
//
//  Created by Snake on 2018/1/23.
//  Copyright © 2018年 Snake. All rights reserved.
//

import UIKit
import Alamofire
import SwiftyJSON

class AddProductViewController: BaseViewController {
    
    @IBOutlet weak var nameTextField: UITextField!
    @IBOutlet weak var seriesTextField: UITextField!
    @IBOutlet weak var contentTextView: UITextView!
    
    var seriesId: Int = 0

    override func viewDidLoad() {
        super.viewDidLoad()

        self.title = "添加产品"
        
        self.contentTextView.layer.borderWidth = 1
        self.contentTextView.layer.borderColor = UIColor.lightGray.cgColor

    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    // =================================
    // MARK:
    // =================================
    
    @IBAction func chooseSeriesButtonDidTouch(_ sender: Any) {
        let vc = ChooseSeriesViewController()
        vc.chooseSeriesCallback = {
            (seriesId, seriesName) in
            self.seriesId = seriesId
            self.seriesTextField.text = seriesName
        }
        self.push(vc)
    }
    
    
    @IBAction func confirmButtonDidTouch(_ sender: Any) {
        if (self.nameTextField.text?.isEmpty)! || (self.seriesTextField.text?.isEmpty)! || self.contentTextView.text.isEmpty {
            self.showErrorTips("内容不能为空")
            return
        }
        
        let parameters: Parameters = ["introduction": self.contentTextView.text,
                                      "name": self.nameTextField.text!,
                                      "seriedId": self.seriesId]
        let apiName = URLManager.feitian_product()
        HttpManager.shareManager.postRequest(apiName, parameters: parameters, encoding: JSONEncoding.default).responseJSON { (response) in
            if let _ = HttpManager.parseDataResponse(response: response) {
                self.showSuccessTips("新增成功")
                self.back()
            } else {
                self.showErrorTips("新增失败")
                self.perform(#selector(self.hideTips), with: self, afterDelay: 1)
            }
        }
        
    }
    

}
