//
//  AddNewsReleaseViewController.swift
//  Snake_Feitian
//
//  Created by Snake on 2018/1/14.
//  Copyright © 2018年 Snake. All rights reserved.
//

import UIKit
import Alamofire
import SwiftyJSON

//1、若角色为店长
//      则“发送范围”不显示，该消息默认发送到该店
//2、若角色为区域经理
//      则“发送范围”显示(有两个可选项，“店”和“区域”)，当“发送范围”选定为店的时候，下方的“具体店铺”从不可见变为可见，供用户选择具体店铺
//      当“发送范围”选定为“区域”时，下方的“具体店铺”变为不可见，默认发送到该区域
//3、当角色为总经理或经理助理时
//      则“发送范围”显示(有三个可选项，“店”和“区域”，以及“全体”)
//      交互与区域经理基本一致：
//      当“发送范围”选定为店的时候，下方的“具体店铺”从不可见变为可见，供用户选择具体店铺
//      当“发送范围”选定为“区域”时，下方的“具体店铺”变为可见，供用户选择具体区域
//      当“发送范围”选定为“全体”时，下方的“具体店铺”变为不可见，默认发送到全体人员

class AddNewsReleaseViewController: BaseViewController, UITextFieldDelegate, UITextViewDelegate {

    @IBOutlet weak var titleTextField: UITextField!
    @IBOutlet weak var contentTextView: UITextView!
    
    //
    @IBOutlet weak var isHiddenScopeView: UIView!
    @IBOutlet weak var scopeTextField: UITextField!
    
    //
    @IBOutlet weak var isHiddenShopView: UIView!
    @IBOutlet weak var shopTextField: UITextField!
    
    let role = SessionManager.share.userModel.role
    
    var scope = 0 // 范围，1=全部，2=区域，3=店铺，4=个人
    var toId = 0 // 所选择范围的范围id，比如选了区域，这个就填区域id；选了店铺，这个就填店铺id；选全部范围的话这个可以不填
    var type = 1 // 1=工作消息，2=售后消息，3=其他消息

    override func viewDidLoad() {
        super.viewDidLoad()

        self.title = "新消息"
        //
        self.contentTextView.layer.borderWidth = 1
        self.contentTextView.layer.borderColor = UIColor.lightGray.cgColor
        
        // 权限控制
        self.authorityControl()
        

    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    // =================================
    // MARK:
    // =================================
    
    func scrollViewDidScroll(_ scrollView: UIScrollView) {
        self.contentTextView.resignFirstResponder()
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
    
    @IBAction func chooseScopeButtonDidTouch(_ sender: Any) {
        //
        let alertVC = UIAlertController.init(title: "请选择发送范围", message: "", preferredStyle: UIAlertControllerStyle.actionSheet)
        //
        let allAction = UIAlertAction.init(title: "全体", style: UIAlertActionStyle.default, handler: { (_) in
            // 当“发送范围”选定为“全体”时，下方的“具体店铺”变为不可见，默认发送到全体人员
            self.scopeTextField.text = "全体"
            self.isHiddenShopView.isHidden = true
        })
        //
        let areaAction = UIAlertAction.init(title: "区域", style: UIAlertActionStyle.default, handler: { (_) in
            // 当“发送范围”选定为“区域”时，下方的“具体店铺”变为可见，供用户选择具体区域
            self.scopeTextField.text = "区域"
            self.scope = 2
            self.isHiddenShopView.isHidden = false
        })
        //
        let shopAction = UIAlertAction.init(title: "店铺", style: UIAlertActionStyle.default, handler: { (_) in
            // 当“发送范围”选定为店的时候，下方的“具体店铺”从不可见变为可见，供用户选择具体店铺
            self.scopeTextField.text = "店铺"
            self.scope = 3
            self.isHiddenShopView.isHidden = false
        })
        //
        let cancelAction = UIAlertAction.init(title: "取消", style: UIAlertActionStyle.cancel, handler: nil)
        //
        alertVC.addAction(cancelAction)
        
        // 权限控制
        if self.role == role_FeiTian.regionalManager.rawValue {
            alertVC.addAction(shopAction)
            alertVC.addAction(areaAction)
        }
        
        if self.role == role_FeiTian.generalManager.rawValue || self.role == role_FeiTian.executiveAssistant.rawValue {
            alertVC.addAction(shopAction)
            alertVC.addAction(areaAction)
            alertVC.addAction(allAction)
        }

        
        //
        self.present(alertVC, animated: true, completion: nil)
    }

    
    @IBAction func chooseShopButtonDidTouch(_ sender: Any) {
        // 所在店铺
        if self.scope == 3 {
            let chooseShopVC = ChooseShopViewController()
            chooseShopVC.chooseShopCallback = {
                (branchId: Int, branchName: String) in
                self.shopTextField.text = "\(branchName)"
                self.toId = branchId
            }
            self.push(chooseShopVC)
        }
        
        // 所在区域
        if self.scope == 2 {
            let chooseAreaVC = ChooseAreaViewController()
            chooseAreaVC.chooseAreaCallback = {
                (areaId: Int, areaName: String) in
                self.shopTextField.text = "\(areaName)"
                self.toId = areaId
            }
            self.push(chooseAreaVC)
        }
        
    }
    
    
    @IBAction func confirmButtonDidTouch(_ sender: Any) {
        let apiName = URLManager.feitian_message()
        
        let content = self.contentTextView.text ?? ""
        let title = self.titleTextField.text ?? ""
        
        let userId = SessionManager.share.userId
        
        let parameters: Parameters = ["content": content,
                                      "scope": self.scope,
                                      "title": title,
                                      "toId": self.toId,
                                      "type": self.type,
                                      "userId": userId]
        //
        HttpManager.shareManager.postRequest(apiName, parameters: parameters, encoding: JSONEncoding.default).responseJSON { (response) in
            if let _ = HttpManager.parseDataResponse(response: response) {
                //
                self.back()
                self.showSuccessTips("新增成功")
            } else {
                self.showErrorTips("新增失败")
            }
        }
        
    }
    
    // =================================
    // MARK:
    // =================================
    
    // 权限控制
    func authorityControl() {
        
        // 若角色为店长 则“发送范围”不显示，该消息默认发送到该店
        if self.role == role_FeiTian.shopowner.rawValue {
            self.isHiddenScopeView.isHidden = true
            self.isHiddenShopView.isHidden = true
        } else {
            self.isHiddenScopeView.isHidden = false
            self.isHiddenShopView.isHidden = false
        }
        
    }
    

}
