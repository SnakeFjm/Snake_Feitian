//
//  AddNewShopViewController.swift
//  Snake-OrderSystem
//
//  Created by Snake on 2017/11/20.
//  Copyright © 2017年 Snake. All rights reserved.
//

import UIKit
import SwiftyJSON
import Alamofire

class AddNewShopViewController: BaseViewController, UITextFieldDelegate {

    @IBOutlet weak var shopNameTextField: UITextField!
    @IBOutlet weak var shopManagerNameTextField: UITextField!
    @IBOutlet weak var shopPlaceTextField: UITextField!
    @IBOutlet weak var phoneTextField: UITextField!
    
    var shopManagerId: Int = 0
    
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
    
    @IBAction func chooseShopownerButtonDidTouch(_ sender: Any) {
        let chooseManagerVC = ChooseManagerViewController()
        chooseManagerVC.choooseMangerCallback = { (shopManagerId: Int, shopManagerName: String) in
            self.shopManagerNameTextField.text = shopManagerName
            self.shopManagerId = shopManagerId
        }
        self.push(chooseManagerVC)
    }
    
    
    @IBAction func confirmButtonDidTouch(_ sender: UIButton) {
        
        if (self.shopNameTextField.text?.isEmpty)! || (self.shopPlaceTextField.text?.isEmpty)! || (self.shopManagerNameTextField.text?.isEmpty)! || (self.phoneTextField.text?.isEmpty)! {
            self.showErrorTips("内容不能为空")
            self.perform(#selector(hideTips), with: self, afterDelay: 1)
            return
        }
        
        let shopName: String = self.shopNameTextField.text!
        let shopPlace: String = self.shopPlaceTextField.text!
        let phone: String = self.phoneTextField.text!
        let shopManagerId: Int = self.shopManagerId
        
        let parameters: Parameters = [ "address": shopPlace,
                                       "contact": phone,
                                       "name": shopName,
                                       "shopManagerId": shopManagerId]
        
        let apiName: String = URLManager.Feitian_branch()
        //
        HttpManager.shareManager.postRequest(apiName, parameters: parameters, encoding: JSONEncoding.default).responseJSON { (response) in
            if let _ = HttpManager.parseDataResponse(response: response) {
                self.navigationController?.popViewController(animated: true)
            }
        }
        
    }
    

    // =================================
    // MARK:
    // =================================
    
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
