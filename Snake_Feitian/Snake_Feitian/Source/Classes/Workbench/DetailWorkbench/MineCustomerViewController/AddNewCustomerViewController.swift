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
    
    override func viewDidLoad() {
        super.viewDidLoad()

        self.navigationItem.title = "新增客户"
        
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
            
            let userId = SessionManager.share.userId
            let apiName = URLManager.feitian_customer()
            //"http://123.207.68.190:21026/api/v1/customer"
            
            let name = self.nameTextField.text!
            let contact = self.contactTextField.text!
            let birthday = self.birthdayTextField.text!
            let physicalStatus = self.bodySituationTextView.text!
            let remarkName = self.remarksTextView.text!
            let sex = 1
            
            let parameters: Parameters = ["adderId": userId,
                                          "name": name,
                                          "contact": contact,
                                          "birthday": birthday,
                                          "physicalStatus": physicalStatus,
                                          "remarkName": remarkName,
                                          "sex": sex]
            
            HttpManager.shareManager.postRequest(apiName, parameters: parameters, encoding: JSONEncoding.default).responseJSON(completionHandler: { (response) in
                if let _ = HttpManager.parseDataResponse(response: response) {
                    let alertVC = showConfirmAlertViewVC(titleVC: "新增成功", message: "返回上一页面", confirmHandler: { (_) in
                        self.navigationController?.popViewController(animated: true)
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
        
        if self.nameTextField.text?.isEmpty ?? false || self.contactTextField.text?.isEmpty ?? false || self.birthdayTextField.text?.isEmpty ?? false || self.bodySituationTextView.text.isEmpty || self.remarksTextView.text.isEmpty {
            
            let alertVC = showConfirmAlertViewVC(titleVC: "提示", message: "内容不能为空", confirmHandler: nil)
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
    
    
}
