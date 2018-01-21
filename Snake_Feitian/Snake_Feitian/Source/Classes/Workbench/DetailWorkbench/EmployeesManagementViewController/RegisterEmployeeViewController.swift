//
//  RegisterEmployeeViewController.swift
//  Snake_Feitian
//
//  Created by Snake on 2018/1/13.
//  Copyright © 2018年 Snake. All rights reserved.
//

import UIKit
import SwiftyJSON
import Alamofire

class RegisterEmployeeViewController: BaseViewController, UITextFieldDelegate {

    @IBOutlet weak var nameTextField: UITextField!
    @IBOutlet weak var genderTextField: UITextField!
    @IBOutlet weak var branchNameTextField: UITextField!
    @IBOutlet weak var staffPositionsTextField: UITextField!
    @IBOutlet weak var mobileTextField: UITextField!
    @IBOutlet weak var birthdayTextField: UITextField!
    @IBOutlet weak var addressTextField: UITextField!
    
    let role = SessionManager.share.userModel.role
    
    override func viewDidLoad() {
        super.viewDidLoad()

        self.title = "员工注册"
        
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    // =================================
    // MARK:
    // =================================
    
    func textFieldDidBeginEditing(_ textField: UITextField) {
        if textField == self.branchNameTextField {
            // 所在店铺
            let chooseShopVC = ChooseShopViewController()
            chooseShopVC.chooseShopCallback = {
                (branchId: Int) in
                self.branchNameTextField.text = "\(branchId)"
            }
            self.push(chooseShopVC)
            
        } else if textField == self.staffPositionsTextField {
            // 员工职位
            let alertVC = UIAlertController.init(title: "请选择员工职位", message: "", preferredStyle: UIAlertControllerStyle.actionSheet)
            //
//            let generalManagerAction = UIAlertAction.init(title: "总经理", style: UIAlertActionStyle.default, handler: { (_) in
//                self.genderTextField.text = "0"
//            })
            //
            let executiveAssistantAction = UIAlertAction.init(title: "经理助理", style: UIAlertActionStyle.default, handler: { (_) in
                self.genderTextField.text = "1"
            })
            let regionalManagerAction = UIAlertAction.init(title: "区域经理", style: UIAlertActionStyle.default, handler: { (_) in
                self.genderTextField.text = "2"
            })
            let shopownerAction = UIAlertAction.init(title: "店长", style: UIAlertActionStyle.default, handler: { (_) in
                self.genderTextField.text = "3"
            })
            let clerkAction = UIAlertAction.init(title: "店员", style: UIAlertActionStyle.default, handler: { (_) in
                self.genderTextField.text = "4"
            })
            let cancelAction = UIAlertAction.init(title: "取消", style: UIAlertActionStyle.cancel, handler: nil)
            //
            alertVC.addAction(cancelAction)
            
            // 权限控制
            if self.role == role_FeiTian.shopowner.rawValue {
                alertVC.addAction(clerkAction)
            }
            
            if self.role == role_FeiTian.regionalManager.rawValue {
                alertVC.addAction(shopownerAction)
                alertVC.addAction(clerkAction)
            }
            
            if self.role == role_FeiTian.executiveAssistant.rawValue {
                alertVC.addAction(regionalManagerAction)
                alertVC.addAction(shopownerAction)
                alertVC.addAction(clerkAction)
            }
            
            if self.role == role_FeiTian.generalManager.rawValue {
                alertVC.addAction(executiveAssistantAction)
                alertVC.addAction(regionalManagerAction)
                alertVC.addAction(shopownerAction)
                alertVC.addAction(clerkAction)
            }
            
            //
            self.present(alertVC, animated: true, completion: nil)
            
        } else if textField == self.genderTextField {
            // 性别
            let alertVC = UIAlertController.init(title: "请选择性别", message: "", preferredStyle: UIAlertControllerStyle.actionSheet)
            //
            let maleAction = UIAlertAction.init(title: "男", style: UIAlertActionStyle.default, handler: { (_) in
                self.genderTextField.text = "男"
            })
            //
            let femaleAction = UIAlertAction.init(title: "女", style: UIAlertActionStyle.default, handler: { (_) in
                self.genderTextField.text = "女"
            })
            let cancelAction = UIAlertAction.init(title: "取消", style: UIAlertActionStyle.cancel, handler: nil)
            //
            alertVC.addAction(cancelAction)
            alertVC.addAction(maleAction)
            alertVC.addAction(femaleAction)
            //
            self.present(alertVC, animated: true, completion: nil)
        }
        
        
    }
    
    func textFieldShouldReturn(_ textField: UITextField) -> Bool {
        textField.resignFirstResponder()
        return true
    }
    
    // =================================
    // MARK:
    // =================================
    
    @IBAction func confirmButtonDidtouch(_ sender: Any) {
        //
        if (self.nameTextField.text?.isEmpty)!
            || (self.genderTextField.text?.isEmpty)!
            || (self.branchNameTextField.text?.isEmpty)!
            || (self.staffPositionsTextField.text?.isEmpty)!
            || (self.mobileTextField.text?.isEmpty)!
            || (self.birthdayTextField.text?.isEmpty)!
            || (self.addressTextField.text?.isEmpty)! {
            self.showErrorTips("内容不能为空")
            return
        }
        //
        self.registerEmployee()
    }
    
    // =================================
    // MARK:
    // =================================
    
    func registerEmployee() {
        let apiName = URLManager.feitian_user()
        let parameters: Parameters = ["address": self.addressTextField.text!,
                                      "birthday": self.birthdayTextField.text!,
                                      "branchId": Int(self.branchNameTextField.text!) ?? 0,
                                      "contact": self.mobileTextField.text!,
                                      "name": self.nameTextField.text!,
                                      "remark": "",
                                      "role": Int(self.staffPositionsTextField.text!) ?? 0,
                                      "sex": self.genderTextField.text!]
        //
        HttpManager.shareManager.postRequest(apiName, parameters: parameters, encoding: JSONEncoding.default).responseJSON { (response) in
            if let _ = HttpManager.parseDataResponse(response: response) {
                self.back()
            }
        }
    }
    

}
