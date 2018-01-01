//
//  AddNewShopViewController.swift
//  Snake-OrderSystem
//
//  Created by Snake on 2017/11/20.
//  Copyright © 2017年 Snake. All rights reserved.
//

import UIKit

class AddNewShopViewController: BaseViewController, UITextFieldDelegate {

    @IBOutlet weak var shopNameTextField: UITextField!
    
    @IBOutlet weak var shopManagerNameTextField: UITextField!
    
    @IBOutlet weak var shopPlaceTextField: UITextField!
    
    @IBOutlet weak var phoneTextField: UITextField!
    
    override func viewDidLoad() {
        super.viewDidLoad()

        self.navigationItem.title = "新增店铺"
    
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    // =================================
    // MARK:
    // =================================
    
    @IBAction func confirmButtonDidTouch(_ sender: UIButton) {
        
//        let shopManagerName = self.shopManagerNameTextField.text

        let shopName: String = self.shopNameTextField.text!
        let shopPlace: String = self.shopPlaceTextField.text!
        let phone: String = self.phoneTextField.text!
//        let shopManagerId =
        
        let apiName: String = "http://123.207.68.190:21026/api/v1/branch"
        let dict: NSDictionary = [ "address": shopPlace,
                                   "contact": phone,
                                   "name": shopName,
                                   "shopManagerId": 55]
        
//        HttpRequestManager.sharedManager.postRequest(apiName: apiName, paramDict: dict) { (isSuccess: Bool, resultObject: Any) in
//            if isSuccess {
//                self.navigationController?.popViewController(animated: true)
//            }
//        }
        
    }
    

    // =================================
    // MARK:
    // =================================
    
    func textFieldDidBeginEditing(_ textField: UITextField) {
        
        if textField == self.shopManagerNameTextField {
            let alertVC: UIAlertController = UIAlertController.init(title: "请选择要分配的店长", message: "选择后自动填入对应的id", preferredStyle: .actionSheet)
            let cancelAction: UIAlertAction = UIAlertAction.init(title: "取消", style: .cancel, handler: nil)
            
            alertVC.addAction(cancelAction)
            self.present(alertVC, animated: true, completion: nil)
        } else {
            //textField.resignFirstResponder()
        }

    }
    
    func textFieldShouldReturn(_ textField: UITextField) -> Bool {
        textField.resignFirstResponder()
        return true
    }

    func textFieldShouldClear(_ textField: UITextField) -> Bool {
        
        if textField != self.shopManagerNameTextField {
            return true
        }
        return false
    }

}
