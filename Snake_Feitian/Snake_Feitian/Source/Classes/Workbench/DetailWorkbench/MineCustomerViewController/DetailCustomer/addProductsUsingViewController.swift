//
//  addProductsUsingViewController.swift
//  Snake_Feitian
//
//  Created by Snake on 2018/1/20.
//  Copyright © 2018年 Snake. All rights reserved.
//

import UIKit
import Alamofire
import SwiftyJSON

class addProductsUsingViewController: UIViewController {
    
    @IBOutlet weak var seriesTextField: UITextField!
    @IBOutlet weak var productNameTextField: UITextField!
    @IBOutlet weak var productNumberTextField: UITextField!
    @IBOutlet weak var addTimeTextField: UITextField!
    @IBOutlet weak var isAddAutomaticallyTextField: UITextField!    
    
    var customerModel: CustomerModel!
    
    let dateFormatter = DateFormatter.init()
    
    var seriesId: Int = 0
    var productId: Int = 0
    var productCount: Int = 0
    var isaddAutomatically: Bool = false

    override func viewDidLoad() {
        super.viewDidLoad()

        self.title = "添加在用产品"
        //
        self.dateFormatter.dateFormat = "yyyy-MM-dd"
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    // =================================
    // MARK:
    // =================================
    
    @IBAction func chooseSeriesButtonDidTouch(_ sender: Any) {
        
        self.productNumberTextField.resignFirstResponder()
        //
        let vc = ChooseSeriesViewController()
        vc.chooseSeriesCallback = {
            (seriesId, seriesName) in
            self.seriesTextField.text = seriesName
            self.seriesId = seriesId
        }
        self.push(vc)
    }
    
    @IBAction func chooseProductNameButtonDidTouch(_ sender: Any) {
        
        self.productNumberTextField.resignFirstResponder()
        //
        if (self.seriesTextField.text?.isEmpty)! {
            self.showErrorTips("请先选择产品系列")
            self.perform(#selector(hideTips), with: self, afterDelay: 1)
            return
        }
        //
        let vc = ChooseProductViewController()
        vc.seriesId = self.seriesId
        vc.chooseProductCallback = {
            (productId, productName) in
            self.productNameTextField.text = productName
            self.productId = productId
        }
        self.push(vc)
    }
    
    @IBAction func chooseAddTimeButtonDidTouch(_ sender: Any) {
        
        self.productNumberTextField.resignFirstResponder()
        //
        let customView = UIView()
        customView.translatesAutoresizingMaskIntoConstraints = false
        customView.addConstraint(NSLayoutConstraint(item: customView,
                                                    attribute: .height,
                                                    relatedBy: .equal,
                                                    toItem: nil,
                                                    attribute: .notAnAttribute,
                                                    multiplier: 1,
                                                    constant: 100))
        //
        let datePicker = UIDatePicker.init(frame: CGRect.init(x: 0, y: 0, width: customView.bounds.size.width, height: customView.bounds.size.height))
        customView.addSubview(datePicker)
        //将日期选择器区域设置为中文，则选择器日期显示为中文
        datePicker.locale = Locale.init(identifier: "zh_CN")
        // 设置样式，当前设为同时显示日期和时间
        datePicker.datePickerMode = UIDatePickerMode.date
        // 设置默认时间
        datePicker.date = Date()
        //
        let alert = UIAlertController(title: "选择生日时间",customView: customView,fallbackMessage: "",preferredStyle: .actionSheet)
        //
        alert.addAction(UIAlertAction(title: "确定", style: UIAlertActionStyle.default){
            (alertAction)->Void in
            let currentDate = datePicker.date
            let dateString = self.dateFormatter.string(from: currentDate)
            self.addTimeTextField.text = dateString
        })
        alert.addAction(UIAlertAction(title: "取消", style: UIAlertActionStyle.cancel,handler:nil))
        //
        self.present(alert, animated: true, completion: nil)
    }
    
    @IBAction func isAddAutomaticallyButtonDidTouch(_ sender: Any) {
        
        self.productNumberTextField.resignFirstResponder()
        //
        let alertVC = UIAlertController.init(title: "是否自动添加", message: "", preferredStyle: .actionSheet)
        alertVC.addAction(UIAlertAction.init(title: "是", style: .default, handler: { (alertAction) in
            self.isAddAutomaticallyTextField.text = alertAction.title
        }))
        alertVC.addAction(UIAlertAction.init(title: "否", style: .default, handler: { (alertAction) in
            self.isAddAutomaticallyTextField.text = alertAction.title
        }))
        //
        self.present(alertVC, animated: true, completion: nil)
    }
    
    @IBAction func AddButtonDidTouch(_ sender: Any) {
        if (self.seriesTextField.text?.isEmpty)! || (self.productNameTextField.text?.isEmpty)! || (self.productNumberTextField.text?.isEmpty)! || (self.addTimeTextField.text?.isEmpty)! || (self.isAddAutomaticallyTextField.text?.isEmpty)! {
            self.showErrorTips("内容不能为空")
            self.perform(#selector(hideTips), with: self, afterDelay: 1)
            return
        }
        
        if let num = Int(self.productNumberTextField.text!) {
            self.productCount = num
        }
        
        let customerId = self.customerModel.id
        let adderId = SessionManager.share.userModel.id
        
        let apiName = URLManager.feitian_productCustomer()
        let parameters: Parameters = ["adderId": adderId,
                                      "customerId": customerId,
                                      "isAddFollowUp": self.isaddAutomatically,
                                      "productCount": self.productCount,
                                      "productId": self.productId]
        
        HttpManager.shareManager.postRequest(apiName, parameters: parameters, encoding: JSONEncoding.default).responseJSON { (response) in
            if let _ = HttpManager.parseDataResponse(response: response) {
                self.showSuccessTips("添加成功")
                self.back()
            } else {
                self.showErrorTips("添加失败")
            }
        }
        
    }
    
    
}
