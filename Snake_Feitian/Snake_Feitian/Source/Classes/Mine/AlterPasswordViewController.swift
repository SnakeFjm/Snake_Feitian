//
//  AlterPasswordViewController.swift
//  Snake_Feitian
//
//  Created by Snake on 2018/1/14.
//  Copyright © 2018年 Snake. All rights reserved.
//

import UIKit
import SwiftyJSON
import Alamofire

class AlterPasswordViewController: BaseViewController, UITextFieldDelegate {

    @IBOutlet weak var originPasswordTextField: UITextField!
    @IBOutlet weak var newPasswordTextField: UITextField!
    @IBOutlet weak var confirmPasswordTextField: UITextField!
    
    override func viewDidLoad() {
        super.viewDidLoad()

        self.title = "修改密码"

    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    // =================================
    // MARK:
    // =================================
    
    func textFieldShouldReturn(_ textField: UITextField) -> Bool {
        textField.resignFirstResponder()
        return true
    }
    
    // =================================
    // MARK:
    // =================================
    
    @IBAction func confirmButtonDidTOuch(_ sender: Any) {
        
        if (self.originPasswordTextField.text?.isEmpty)! || (self.newPasswordTextField.text?.isEmpty)! || (self.confirmPasswordTextField.text?.isEmpty)! {
            showErrorTips("内容不能为空")
            return
        }
        
        if self.newPasswordTextField.text != self.confirmPasswordTextField.text {
            showErrorTips("新密码与确认密码不一致")
            return
        }
        
        let oldPassword: String = (self.originPasswordTextField.text?.md5())!
        let newPassword: String = (self.confirmPasswordTextField.text?.md5())!
        
        self.alertPassword(oldPassword: oldPassword, newPassword: newPassword)
        
    }
    
    func alertPassword(oldPassword: String, newPassword: String) {
        let apiName = URLManager.feitian_userPassword()
        //
        if let id = SessionManager.share.basicInformation["id"] as? Int {
            let parameters: Parameters = ["id": id,
                                          "newPassword": oldPassword,
                                          "oldPassword": newPassword]
            //
            HttpManager.shareManager.postRequest(apiName, parameters: parameters, encoding: JSONEncoding.default).responseJSON { (response) in
                if let _ = HttpManager.parseDataResponse(response: response) {
                    self.showSuccessTips("修改成功")
                    self.back()
                }
            }
        }
        
    }

}
