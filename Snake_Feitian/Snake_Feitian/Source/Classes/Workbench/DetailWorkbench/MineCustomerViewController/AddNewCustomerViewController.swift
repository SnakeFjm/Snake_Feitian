//
//  AddNewCustomerViewController.swift
//  Snake-OrderSystem
//
//  Created by Snake on 2017/12/5.
//  Copyright © 2017年 Snake. All rights reserved.
//

import UIKit
import SwiftyJSON
import Alamofire

class AddNewCustomerViewController: BaseViewController, UITextFieldDelegate, UITextViewDelegate {

    @IBOutlet weak var nameTextField: UITextField!
    @IBOutlet weak var contactTextField: UITextField!
    @IBOutlet weak var birthdayTextField: UITextField!
    @IBOutlet weak var bodySituationTextView: UITextView!
    @IBOutlet weak var remarksTextView: UITextView!
    
    let dateFormatter = DateFormatter.init()
    
    override func viewDidLoad() {
        super.viewDidLoad()

        self.navigationItem.title = "新增客户"
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
    
    @IBAction func confirmButtonDidTouch(_ sender: UIButton) {

        if !self.checkIfEmpty() {
            
            let userId = SessionManager.share.userModel.id
            let apiName = URLManager.feitian_customer()
            //"http://123.207.68.190:21026/api/v1/customer"
            
            let name = self.nameTextField.text!
            let contact = self.contactTextField.text ?? ""
            let birthday = self.birthdayTextField.text ?? ""
            let physicalStatus = self.bodySituationTextView.text!
            let remarkName = self.remarksTextView.text ?? ""
            let sex = 1
            
            let parameters: Parameters = ["adderId": userId,
                                          "name": name,
                                          "contact": contact,
                                          "birthday": birthday,
                                          "physicalStatus": physicalStatus,
                                          "remarkName": remarkName,
                                          "sex": sex]
            //
            HttpManager.shareManager.postRequest(apiName, parameters: parameters, encoding: JSONEncoding.default).responseJSON(completionHandler: { (response) in
                if let _ = HttpManager.parseDataResponse(response: response) {
                    let alertVC = showConfirmAlertViewVC(titleVC: "新增成功", message: "返回上一页面", confirmHandler: { (_) in
                        self.back()
                    })
                    self.present(alertVC, animated: true, completion: nil)
                } else {
                    let alertVC = showConfirmAlertViewVC(titleVC: "新增失败", message: "", confirmHandler: nil)
                    self.present(alertVC, animated: true, completion: nil)
                }
            })
        }
    }
    
    func checkIfEmpty() -> Bool {
        
        if self.nameTextField.text?.isEmpty ?? false || self.bodySituationTextView.text.isEmpty {
            
            let alertVC = showConfirmAlertViewVC(titleVC: "提示", message: "联系方式和备注不能为空", confirmHandler: nil)
            self.present(alertVC, animated: true, completion: nil)
            
            return true
        }
        
        return false
    }
    
    
    // =================================
    // MARK:
    // =================================
    
    func textFieldShouldReturn(_ textField: UITextField) -> Bool {
        textField.resignFirstResponder()
        return true
    }
    
    func textFieldShouldClear(_ textField: UITextField) -> Bool {
        return true
    }
    
    // =================================
    // MARK:
    // =================================

    func textView(_ textView: UITextView, shouldChangeTextIn range: NSRange, replacementText text: String) -> Bool {
        if text == "\n" {
            textView.resignFirstResponder()
            return false
        }
        return true
    }
    
    // =================================
    // MARK:
    // =================================
    
    @IBAction func chooseBirthdayButtonDidTouch(_ sender: Any) {
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
            self.birthdayTextField.text = dateString
        })
        alert.addAction(UIAlertAction(title: "取消", style: UIAlertActionStyle.cancel,handler:nil))
        //
        self.present(alert, animated: true, completion: nil)
    }
    
}
